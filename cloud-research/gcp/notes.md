# GCP SDK Code Generation — Research Notes

Research date: 2026-05-30. SHAs pinned at time of research:

- `googleapis/googleapis` @ `0054cdcbd8ea44298f329d916d8173dd736fbaaa`
- `googleapis/gapic-generator-python` @ `5f2ad19546814408feeab2bd8a62218276f3432f`
- `googleapis/gapic-generator-java` / `googleapis/sdk-platform-java` @ `febe86f1ea4f0b5e6d8454024ed499adb7dc9328`
- `googleapis/gapic-generator-go` @ `df09eaf023d80438e826f304e4d03d86519c6d04`
- `googleapis/gapic-generator-typescript` @ `ed34a7351630e0c9003c6f68a2725d744055066f`
- `googleapis/google-cloud-python` @ `6b62cb6fb3de94326b8944ae08a400c12529cad2`
- `googleapis/google-cloud-go` @ `2b4ac429c5328ed230ead5e937cd11f7024b73bf`
- `googleapis/google-cloud-java` (monorepo) — read at `main` (couldn't pin per-file SHA cheaply; `?? verify: pin per-file SHAs`)
- `googleapis/google-cloud-node` @ `371ea4d414b7b4976d81197059df624a63edce69`
- `googleapis/repo-automation-bots` (OwlBot) @ `b5ead0e43eb89f826c2445d694c15dd52a2e5d25`

---

## Big picture (TL;DR)

GCP's "industrial" SDK pipeline is centered on **Protocol Buffers in
`googleapis/googleapis`** annotated with `google/api/*.proto` extensions, plus a
**service config YAML** (and a gRPC service-config JSON) per API. **Bazel BUILD
rules** in `googleapis/googleapis` invoke one **GAPIC generator per language**
(each a separate open-source repo, each written *in* its target language), which
are `protoc` plugins. Generated code historically landed in a flat mirror repo
**`googleapis/googleapis-gen`** and was synced into the per-language client repos
by **OwlBot** (a post-processor bot) + **synthtool** (`owlbot.py`). Storage and
Pub/Sub are the famous cases where the GAPIC-generated low-level client is wrapped
(or replaced) by **hand-written** idiomatic clients.

**Important currency note:** the pipeline is mid-migration. OwlBot's README now
says it is **"⛔️ DEPRECATED ... planned for shutdown"** and is being replaced by a
new Go CLI **`googleapis/librarian`** (created 2024-11-22) driving a **hermetic
(Docker-based) build**. Evidence: `google-cloud-python` now contains a
`librarian.yaml`, and `google-cloud-java` packages carry `.OwlBot-hermetic.yaml`.
`googleapis-gen` itself now returns **404 over the public API/git** (made private
or removed) — see "gaps".

---

## 1. Service description / IDL

**Primary IDL: Protocol Buffers in `googleapis/googleapis`.** Each API lives under
`google/<area>/<version>/`, e.g. `google/pubsub/v1/pubsub.proto`,
`google/storage/v2/storage.proto`, `google/cloud/functions/v2/functions.proto`.
These are human-authored and public (Apache-2.0 repo).

The protos are decorated with annotation protos under `google/api/`:
`annotations.proto`, `client.proto`, `field_behavior.proto`, `resource.proto`,
`http.proto`, `field_info.proto`, `launch_stage.proto`. These annotations are the
machine-readable hints that drive idiomatic generation (see §4).

Per API there is also:
- a **service config YAML** (`type: google.api.Service`, `config_version: 3`),
  e.g. `google/pubsub/v1/pubsub_v1.yaml` — declares the APIs, documentation
  overrides, HTTP rules, publishing settings. Human-authored.
- a **gRPC service config JSON**, e.g. `pubsub_grpc_service_config.json` — retry /
  timeout / method-config defaults.
- sometimes a legacy **`*_gapic.yaml`** (e.g. `pubsub_gapic.yaml`) — older GAPIC
  config still referenced by Java/PHP/Ruby Bazel targets.

Verified contents:
- pubsub v1 dir listing: `BUILD.bazel`, `pubsub.proto`, `pubsub_gapic.yaml`,
  `pubsub_grpc_service_config.json`, `pubsub_v1.yaml`, `schema.proto`.
- storage v2 dir: `BUILD.bazel`, `README.md`, `storage.proto`,
  `storage_grpc_service_config.json`, `storage_v2.yaml`.
- functions v2 dir: `BUILD.bazel`, `cloudfunctions_v2.yaml`, `functions.proto`,
  `functions_grpc_service_config.json`.

`storage.proto` *is* a real gRPC API surface (service `Storage`, rpcs
`GetBucket`, `ReadObject` (server-streaming), `WriteObject` (client-streaming),
`ListObjects` …) — important because Storage's public clients are largely
hand-written JSON/HTTP, yet a gRPC proto also exists (used e.g. by Go's
`grpc_client.go`). See:
`google/storage/v2/storage.proto` lines `67` (`service Storage`), `403`
(`ReadObject`), `513` (`WriteObject`).

**Legacy Discovery Documents.** Older/non-GAPIC libraries (the
`google-api-*-client` family, e.g. `googleapis/google-api-python-client` — "The
official Python client library for Google's discovery based APIs") are generated
from **Discovery Documents** (JSON), not from these protos. The Discovery
artifacts are mirrored/managed in `googleapis/discovery-artifact-manager`. This is
a separate, older generation track from GAPIC.

## 2. Generator tool(s)

**One GAPIC generator per language, each its own Apache-2.0 repo, each a `protoc`
plugin, each written in its target language** (this is a deliberate divergence —
they do NOT share a template engine):

| Language | Repo | License | Impl language | Engine / approach |
|---|---|---|---|---|
| Python | `googleapis/gapic-generator-python` | Apache-2.0 | Python | **Jinja2** templates (115 `.j2` files; `jinja2 >= 2.11` in `setup.py`) |
| Java | `googleapis/gapic-generator-java` (in `googleapis/sdk-platform-java`) | Apache-2.0 | Java | **AST / visitor codegen** (`engine/ast`, `JavaWriterVisitor`, `JavaFormatter`) — NOT Jinja2 |
| Go | `googleapis/gapic-generator-go` | Apache-2.0 | Go | Go-native `protoc` plugin `protoc-gen-go_gapic`, Go string/`text/template` building |
| TypeScript | `googleapis/gapic-generator-typescript` | Apache-2.0 | TypeScript | **Nunjucks** templates (`.njk`, 86 files) |

Verified:
- Python uses Jinja2: `gapic/templates/*.j2` present; `setup.py` declares
  `jinja2 >= 2.11`, `protobuf`, `grpcio`.
- Java uses an AST writer, not templates:
  `gapic-generator-java/src/main/java/com/google/api/generator/engine/writer/JavaWriterVisitor.java`,
  `ImportWriterVisitor.java`, `JavaFormatter.java` (212 `.java` source files under
  `gapic-generator-java/src/main/java`).
- Go generator README: "The generator works as a `protoc` plugin"; install via
  `protoc-gen-go_gapic`; invoked with `--go_gapic_out` / `--go_gapic_opt`.
- TS generator README: "[Nunjucks] templates located in the `templates` folder".

Below the GAPIC layer, the standard `protoc` plugins emit the proto message /
gRPC stub code per language (`java_proto_library`, `java_grpc_library`,
`go_proto`, `py`/`grpcio` stubs, `nodejs` proto loading), wired in the same
BUILD.bazel.

**Bazel BUILD rules in `googleapis`** are the glue. Example
`google/pubsub/v1/BUILD.bazel` loads from
`@com_google_googleapis_imports//:imports.bzl` and declares per-language targets:
`proto_library` (L11), `proto_library_with_info` (L30), then
`java_gapic_library` (L51), `py_gapic_library` (L92), `go_gapic_library` (L131),
`nodejs_gapic_library` (L183), plus php/ruby/csharp/cc. Each GAPIC rule passes
`grpc_service_config`, `service_yaml` (and Java/PHP/Ruby also `gapic_yaml`) and
`transport = "grpc+rest"`. So the spec → generator binding is entirely declared
in Bazel.

## 3. Pipeline / orchestration

1. **Bazel-driven generation.** `bazel build //google/pubsub/v1:pubsub_py_gapic`
   (etc.) runs the right GAPIC generator over the proto + configs. Each language
   also has an `*_gapic_assembly_pkg` target that bundles a publishable artifact
   (e.g. `pubsub-v1-py` L118, `gapi-cloud-pubsub-v1-go` L148,
   `pubsub-v1-nodejs` L199 in the pubsub BUILD.bazel).
2. **`googleapis/googleapis-gen` mirror.** Historically, CI built *every* Bazel
   target and committed the raw generated output to a flat mirror repo
   `googleapis-gen` (one source of truth for generated code, mapping proto path →
   generated artifacts). `?? verify: googleapis-gen now 404s over public
   gh api / git ls-remote (made private or removed) — confirm whether it was
   replaced by hermetic-build artifacts rather than a committed mirror.`
3. **OwlBot post-processing / sync.** `googleapis/repo-automation-bots`
   `packages/owl-bot`. Per the README, OwlBot runs a per-language **Docker
   post-processor** on every PR to a repo containing an `.OwlBot.yaml`, to enforce
   the Yoshi team's "common look and feel" (README updates, doc-link updates,
   lint/format). It copies generated code out of the mirror into language repos
   using `deep-copy-regex` / `deep-remove-regex` / `deep-preserve-regex` rules,
   and runs **synthtool** (`owlbot.py`) for per-library transforms. **The OwlBot
   README header now reads "⛔️ DEPRECATED ... planned for shutdown."**
4. **synthtool / `owlbot.py`.** Per-library Python scripts (`import synthtool as
   s`) move staging dirs into place and apply replacements. Example:
   `java-storage/owlbot.py` deletes a stray `gapic_metadata.json`, calls
   `s.move(library)`, `s.remove_staging_dirs()`, and `java.common_templates(...)`.
5. **Successor: `googleapis/librarian` (Go CLI) + hermetic build.** "CLI for
   managing SDK client library configuration, generation and releases ... onboarding
   new libraries, generating code from API specifications, bumping versions, and
   publishing releases." `google-cloud-python` now has a `librarian.yaml`
   (`language: python`, pins a `googleapis` source commit + sha256). Java packages
   carry `.OwlBot-hermetic.yaml` (the hermetic variant of the OwlBot copy config).
6. **Monorepo vs polyrepo.** Trend is toward **per-language monorepos**:
   `google-cloud-python/packages/google-cloud-*`,
   `google-cloud-go/<module>`, `google-cloud-java/java-*`,
   `google-cloud-node/packages/*`. Older per-API polyrepos (e.g.
   `googleapis/java-pubsub`, `googleapis/nodejs-storage`,
   `googleapis/nodejs-pubsub`) are now **archived** and migrated into the
   monorepos.

## 4. Per-language customization mechanisms

**(a) Proto annotations are the primary, language-agnostic customization knob.**
The generators read `google/api/*` options:
- `google.api.method_signature` (`client.proto` L46, L65) — generates flattened
  convenience overloads. e.g. pubsub `CreateTopic` has
  `option (google.api.method_signature) = "name"`;
  `UpdateTopic` → `"topic,update_mask"`; `Publish` → `"topic,messages"`
  (`pubsub.proto` L61/L71/L81).
- `google.api.default_host` (`client.proto` L78) + `google.api.oauth_scopes`
  (L100) on the service — wires default endpoint + scopes
  (`pubsub.proto` L49–L50; `storage.proto` L68; `functions.proto` L79).
- `google.api.field_behavior` (REQUIRED/OPTIONAL/OUTPUT_ONLY) — required-field
  validation & docs (e.g. `pubsub.proto` L172 `REQUIRED`).
- `google.api.resource` / `resource_reference` / `resource_definition` — resource
  name helper classes / path builders (`pubsub.proto` L37, L41, L173).
- `google.api.http` — REST transport bindings (every rpc).
- `google.api.client.ClientLibrarySettings` + `Publishing` in the service YAML —
  **per-language settings live in the spec itself**: `client.proto` defines
  `ClientLibrarySettings` with `java_settings` (field 21), `python_settings` (24),
  `node_settings` (25), `go_settings` (28), plus `rest_numeric_enums`,
  `launch_stage`. `Publishing.library_settings` (field 109) is the repeated list.

**(b) Template engines differ per generator** (see §2): Jinja2 (Python),
Nunjucks (TS), AST visitor (Java), Go templates/string-builder (Go).

**(c) OwlBot copy/transform config** expresses repo-level customization:
`.OwlBot.yaml` / `.OwlBot-hermetic.yaml` with `deep-copy-regex`,
`deep-remove-regex`, `deep-preserve-regex`. Example from
`java-storage/.OwlBot-hermetic.yaml`:
```yaml
deep-preserve-regex:
- /.*google-.*/src/main/java/.*/stub/Version.java
deep-remove-regex:
- /.*gapic-google-.*/src
deep-copy-regex:
- source: /google/storage/v2/.*-java/gapic-google-.*/src
  dest: /owl-bot-staging/java-storage/v2/gapic-google-cloud-storage-v2/src
```
`deep-preserve-regex` protects hand-edited files (e.g. `Version.java`,
hand-fixed integration tests) from being overwritten by regenerated code.

**(d) `owlbot.py` (synthtool) post-processors** apply arbitrary Python transforms
+ common templates after the copy (see §3.4).

**(e) The "handwritten vs generated" split.** The generated GAPIC client (e.g.
`*_v1` services) is low-level / 1:1 with the proto. For some products GCP ships an
additional **hand-written idiomatic wrapper** in the *same package* (Pub/Sub) or a
fully hand-written client (Cloud Storage). The split is recorded in each package's
`.repo-metadata.json` `library_type`:
- `GAPIC_AUTO` — pure generated, no handwritten layer (e.g. Cloud Functions).
- `GAPIC_MANUAL` — hand-written client, no generated GAPIC shipped (Storage in
  Python/Go/Node).
- `GAPIC_COMBO` — generated GAPIC + hand-written wrapper coexisting (Pub/Sub
  everywhere; Storage in Java).

## 5. Manual vs generated — case studies

### Cloud Storage (object storage) — the handwritten exemplar
Spec: `google/storage/v2/storage.proto` + `storage_v2.yaml` +
`storage_grpc_service_config.json` (a real gRPC API). But the *public* clients are
largely hand-written JSON/HTTP:

| Lang | Location | library_type | Generated? |
|---|---|---|---|
| Python | `google-cloud-python/packages/google-cloud-storage` | **GAPIC_MANUAL** | Hand-written: `client.py`, `bucket.py`, `blob.py`, `acl.py`, `_http.py`, `transfer_manager.py`, `_signing.py`, etc. (also a `grpc_client.py` + `_experimental`). No shipped GAPIC `*_v2` service client. |
| Go | `google-cloud-go/storage` | **GAPIC_MANUAL** (`client_library_type: manual`) | Hand-written: `client.go`, `bucket.go`, `acl.go`, `copy.go`, plus `grpc_client.go` (gRPC path). |
| Java | `google-cloud-java/java-storage` | **GAPIC_COMBO** | Hand-written `google-cloud-storage` + generated `gapic-google-cloud-storage-v2`, `grpc-google-cloud-storage-v2`, `proto-google-cloud-storage-v2`. Has `owlbot.py` + `.OwlBot-hermetic.yaml`. |
| Node/TS | `googleapis/nodejs-storage` (**archived**) | **GAPIC_MANUAL** | Hand-written TS: `storage.ts`, `bucket.ts`, `file.ts`, `acl.ts`, `hmacKey.ts`, `resumable-upload.ts`, `signer.ts`. `?? verify: current canonical Node Storage location post-archival — not yet a package under google-cloud-node/packages.` |

Key verified line: `google-cloud-storage/.repo-metadata.json` →
`"library_type": "GAPIC_MANUAL"`, `"default_version": "v2"` (Python).

### Pub/Sub (messaging) — generated GAPIC + handwritten wrapper (GAPIC_COMBO)
Spec: `google/pubsub/v1/pubsub.proto` (+ `schema.proto`), `pubsub_v1.yaml`,
`pubsub_grpc_service_config.json`, `pubsub_gapic.yaml`.

| Lang | Location | library_type | Split |
|---|---|---|---|
| Python | `google-cloud-python/packages/google-cloud-pubsub` | **GAPIC_COMBO** | Generated GAPIC under `google/pubsub_v1/` (`services/`, `types/`, `gapic_metadata.json`, `gapic_version.py`). Hand-written wrappers under `google/cloud/pubsub_v1/publisher/` (`client.py`, `_batch`, `_sequencer`, `flow_controller.py`, `futures.py`) and `.../subscriber/`. |
| Go | `google-cloud-go/pubsub` | **GAPIC_MANUAL** (top-level) | Generated GAPIC under `pubsub/apiv1/`; hand-written idiomatic wrappers at top level: `pubsub.go`, `topic.go`, `subscription.go`. |
| Java | `google-cloud-java/java-pubsub` | **GAPIC_COMBO** | Generated `Publisher`/`Subscriber` admin GAPIC + hand-written `Publisher`/`Subscriber` data-plane classes. |
| Node/TS | `googleapis/nodejs-pubsub` (**archived**) | **GAPIC_COMBO** | Hand-written `PubSub`/`Topic`/`Subscription` wrappers over generated v1 client. |

So: Pub/Sub's flow control, batching, lease management, and the ergonomic
`Topic`/`Subscription` types are **hand-authored**; the raw admin/data RPC stubs
are **generated**.

### Cloud Functions (FaaS) — pure generated (GAPIC_AUTO)
Spec: `google/cloud/functions/v2/functions.proto` (+ v1), `cloudfunctions_v2.yaml`,
`functions_grpc_service_config.json`. `functions.proto` service
`FunctionService` (L78) with `method_signature` on `GetFunction`,
`ListFunctions`, `CreateFunction`, `UpdateFunction`, `DeleteFunction`.

| Lang | Location | library_type |
|---|---|---|
| Python | `google-cloud-python/packages/google-cloud-functions` (`google/functions_v1`, `functions_v2`) | **GAPIC_AUTO** |
| Go | `google-cloud-go/functions` (`apiv1`, `apiv2`, `apiv2beta`) | **GAPIC_AUTO** (`functions/apiv2/.repo-metadata.json` → `client_library_type: generated`) |
| Java | `google-cloud-java/java-functions` | **GAPIC_AUTO** |
| Node | `google-cloud-node/packages/google-cloud-functions` | (in monorepo) `?? verify library_type` |

No hand-written wrapper — the generated client *is* the public client.

## 6. Release & versioning

- **Per-package / per-module versioning.** Each library has its own version (e.g.
  Python `gapic_version.py` / `version.py`; Go per-module `go.mod`; Java per-`java-*`
  module pom version). API surface versions are encoded in the proto path
  (`v1`, `v2`, `v2beta`) and surface as parallel client packages
  (`functions_v1` + `functions_v2`, `apiv1` + `apiv2`).
- **release-please.** `googleapis/release-please` (TypeScript, Apache-2.0) —
  "generate release PRs based on the conventionalcommits.org spec." It parses
  Conventional Commits to compute the next SemVer bump, opens a release PR,
  updates CHANGELOG + version files, and tags on merge. This is the cross-language
  release driver for the googleapis monorepos.
- **Successor:** `librarian` also "bump[s] versions, and publish[es] releases,"
  so release-please's role is being folded into the librarian flow in the hermetic
  pipeline. `?? verify: extent to which release-please is already replaced by
  librarian per language.`
- **Breaking changes** surface via (a) a new proto version directory → new client
  package (additive, old kept), and (b) Conventional-Commit `feat!` / `BREAKING
  CHANGE:` → major bump in release-please. GA stability is gated by
  `launch_stage` in `ClientLibrarySettings` (`client.proto`).

---

## Gaps / `?? verify`

1. **`googleapis-gen` access.** Public `gh api repos/googleapis/googleapis-gen` →
   404; `git ls-remote https://github.com/googleapis/googleapis-gen` → "Repository
   not found." Need to confirm whether it was made private, deleted, or superseded
   by the hermetic build (which may generate into language repos directly rather
   than committing to a mirror). Historical descriptions are widely cited but I
   could not verify current file contents.
2. **Node monorepo migration state.** Storage & Pub/Sub Node clients verified only
   from the **archived** `googleapis/nodejs-storage` / `nodejs-pubsub`; they are
   not yet packages under `google-cloud-node/packages`. Confirm canonical current
   location.
3. **Cloud Functions Node `library_type`** not pulled.
4. **Java monorepo per-file SHAs** were read at `main`, not pinned — re-pin before
   quoting in the deliverable.
5. **librarian / hermetic build internals** (exact Docker image, how it replaces
   the OwlBot copy step) read only from README + config presence, not from the
   build implementation. Confirm the end-to-end hermetic flow.
6. Did not run a generator locally (DO_NEXT step 3). Candidate: run
   `gapic-generator-python` (Jinja2, easiest via `uv`) against
   `google/cloud/functions/v2` (pure GAPIC_AUTO) for a clean reproduction.

# Google API client libraries — the Discovery Document family

> Scope: This document covers the **older** of Google's two SDK families: the
> **Discovery Document** ("Google API client libraries") track that covers
> *hundreds* of Google REST APIs (Compute, Drive, Calendar, BigQuery REST,
> Admin SDK, YouTube, etc.). It is distinct from the modern **GAPIC / gRPC**
> family (protobuf → per-language GAPIC generators → the `cloud.google.com/go`,
> `google-cloud-*` packages), which is covered elsewhere. The contrast between
> the two families is summarized at the end.

All commit-pinned permalinks are collected in the [Links](#links) section.
Commits referenced (verified `2026-05-30`):

| Repo | Commit |
| --- | --- |
| `googleapis/discovery-artifact-manager` | `2c68f5855887c1e32368f9a22d05d785821783b0` |
| `googleapis/google-api-python-client` | `6e471c075039dfef24e28d11658e03d5c949c7c3` |
| `googleapis/google-api-go-client` | `3855346eda7f4ba6c844d86de5de493d3e395f00` |
| `googleapis/google-api-nodejs-client` | `9e92f535023f86df98d8a9dcbdf7777434e3124f` |
| `googleapis/google-api-java-client-services` | `2eb69439e022e15bfb494ed78500d4b356939b9d` |
| `googleapis/google-api-java-client` (core runtime) | `81fc9f59601f15d89801721773864addb2ed9c7d` |
| `google/apis-client-generator` | `f09f0ba855c3845d315b811c6234fd3996f33172` |

---

## 1. Source of truth = Discovery Documents (JSON)

The single source of truth for this entire family is the **Discovery Document**
(a JSON object whose `kind` is `discovery#restDescription`), one per
API/version, served at runtime by the **Google API Discovery Service**
(`https://www.googleapis.com/discovery/v1/apis/{api}/{version}/rest`). A
discovery document describes the *complete surface* of one API version:
auth scopes, the `rootUrl`/`basePath`, the resource tree, each method's HTTP
verb + path + parameters, and the JSON `schemas`.

These docs are mirrored / cached in **`googleapis/discovery-artifact-manager`**
under the `discoveries/` directory (512 files at the pinned commit, e.g.
`compute.v1.json`, `compute.beta.json`, `compute.alpha.json`,
`hypercomputecluster.v1.json`). The repo README states its purpose plainly:

> The Discovery Artifact Manager is intended to facilitate testing, publishing,
> and synchronization of generators and artifacts for client libraries [...]
> To aid hermetic testing of client libraries and samples [...] the
> `discoveries` directory hosts a local cache of Discovery docs from the
> [API Discovery Service]. This cache is updated by an internal mechanism [...]
> These documents are only updated if they materially change and are normalized
> (sorted keys) to make reviewing diffs possible.

The same README enumerates the per-language consumer repos (Go, Java,
JS/TS, Ruby, PHP, Python, .NET), confirming the "one spec, many languages"
structure of this family.

### Example: shape of a discovery doc (`compute.v1.json`)

Top of `discoveries/compute.v1.json`:

```json
{
  "auth": { "oauth2": { "scopes": { ... } } },
  "basePath": "/compute/v1/",
  "baseUrl": "https://compute.googleapis.com/compute/v1/",
  "batchPath": "batch/compute/v1",
  "description": "Creates and runs virtual machines on Google Cloud Platform.",
  "discoveryVersion": "v1",
  "id": "compute:v1",
  "kind": "discovery#restDescription",
  "name": "compute",
  "rootUrl": "https://compute.googleapis.com/",
  ...
}
```

A single method node, `resources.instances.methods.get`, illustrates the
data that every generator/runtime walks:

```json
{
  "id": "compute.instances.get",
  "httpMethod": "GET",
  "path": "projects/{project}/zones/{zone}/instances/{instance}",
  "parameters": {
    "instance": { "location": "path", "required": true, "type": "string",
                  "pattern": "[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?|..." },
    "project":  { "location": "path", "required": true, "type": "string", ... },
    "zone":     { "location": "path", "required": true, "type": "string", ... }
  }
}
```

This `resources → methods → {httpMethod, path, parameters, request, response}`
+ top-level `schemas` structure is exactly what each language target consumes —
the key difference being **when** they consume it (runtime vs. build time).

License: `discovery-artifact-manager` is **Apache-2.0**.

---

## 2. `google-api-python-client` — runtime-dynamic (the boto3 parallel)

This is the most important contrast in the family. `google-api-python-client`
ships **no generated per-API Python source**. Instead, like `boto3`/`botocore`
with its JSON service models, it is **data-driven**: a single hand-written
module builds service and method objects **dynamically at runtime** from the
Discovery Document.

The entry point is `googleapiclient.discovery.build(serviceName, version, ...)`.
`build()` fetches (or loads a static/cached copy of) the discovery doc, then
hands it to `build_from_document()`:

```python
# googleapiclient/discovery.py
def build(serviceName, version, ..., static_discovery=None, ...):
    ...
    for discovery_url in _discovery_service_uri_options(discoveryServiceUrl, version):
        requested_url = uritemplate.expand(discovery_url, params)
        content = _retrieve_discovery_doc(requested_url, discovery_http, ...)
        service = build_from_document(content, base=discovery_url, http=http, ...)
        break
    ...
    return service
```

The actual dynamic construction lives in `createMethod()` and the `Resource`
class. `createMethod()` reads a *fragment of the deserialized discovery
document* and **closes over it to produce a Python function** at runtime:

```python
def createMethod(methodName, methodDesc, rootDesc, schema):
    """Creates a method for attaching to a Resource.
    Args:
      methodName: string, name of the method to use.
      methodDesc: object, fragment of deserialized discovery document that
        describes the method.
      rootDesc: object, the entire deserialized discovery document.
      schema: object, mapping of schema names to schema descriptions.
    """
    methodName = fix_method_name(methodName)
    (pathUrl, httpMethod, methodId, accept, maxSize, mediaPathUrl) = \
        _fix_up_method_description(methodDesc, rootDesc, schema)
    parameters = ResourceMethodParameters(methodDesc)

    def method(self, **kwargs):
        # validates kwargs against parameters.argmap / required_params /
        # pattern_params derived from the discovery doc, then issues the HTTP call
        ...
```

`Resource.__init__` takes the `resourceDesc` / `rootDesc` / `schema` (all slices
of the discovery doc) and, via `_set_service_methods()`, **attaches methods and
nested resources onto the instance at runtime** using `setattr`-style dynamic
attributes:

```python
class Resource(object):
    """A class for interacting with a resource."""
    def __init__(self, http, baseUrl, model, requestBuilder, developerKey,
                 resourceDesc, rootDesc, schema, ...):
        ...
        self._set_service_methods()

    def _set_service_methods(self):
        self._add_basic_methods(self._resourceDesc, self._rootDesc, self._schema)
        self._add_nested_resources(self._resourceDesc, self._rootDesc, self._schema)
        self._add_next_methods(self._resourceDesc, self._schema)

    def _add_basic_methods(self, resourceDesc, rootDesc, schema):
        ...
        if "methods" in resourceDesc:
            for methodName, methodDesc in resourceDesc["methods"].items():
                fixedMethodName, method = createMethod(methodName, methodDesc, rootDesc, schema)
                self._set_dynamic_attr(fixedMethodName, method.__get__(self, self.__class__))
```

So a call like:

```python
from googleapiclient.discovery import build
compute = build("compute", "v1")
compute.instances().get(project="p", zone="z", instance="i").execute()
```

builds `.instances()` (a nested `Resource`) and its `.get(...)` method **entirely
at runtime from `compute.v1.json`** — there is no `compute_v1.py` in the package.
This is directly analogous to boto3 reading `botocore` JSON models.

**Static type stubs exist separately.** Because the dynamic construction defeats
static analysis, third-party PEP 561 type stubs are published out-of-tree
(`henribru/google-api-python-client-stubs`, "Type stubs for
google-api-python-client") — these are *stubs only*, not the runtime client.
The library also ships pre-baked static discovery JSON inside the wheel
(`static_discovery=True` by default when no `discoveryServiceUrl` is given), but
the *client objects are still constructed dynamically from that JSON*.

License: `google-api-python-client` is **Apache-2.0** (header on `discovery.py`:
"Copyright 2014 Google Inc. ... Licensed under the Apache License, Version 2.0").

---

## 3. `google-api-go-client` — statically generated by `google-api-go-generator`

Go takes the opposite approach. The repo `googleapis/google-api-go-client`
(import path `google.golang.org/api`) **commits statically generated Go source**,
one package per API/version (`compute/v1/compute-gen.go`, etc.), produced by the
**`google-api-go-generator`** that lives in the same repo
(`google-api-go-generator/gen.go`).

`gen.go` is a `package main` program that reads discovery docs (default index
`https://www.googleapis.com/discovery/v1/apis`), parses them via its internal
`disco` package (`google.golang.org/api/google-api-go-generator/internal/disco`),
and emits Go. The generated file preamble it writes (note: BSD-style, not
Apache, for the Go code) includes a `DO NOT EDIT` banner:

```go
// gen.go — GenerateCode() header emission
pn(`// Copyright %s Google LLC.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// Code generated file. DO NOT EDIT.
`, *copyrightYear)
```

And the matching banner on a real generated file confirms it
(`compute/v1/compute-gen.go`):

```go
// Copyright 2026 Google LLC.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// Code generated file. DO NOT EDIT.

// Package compute provides access to the Compute Engine API.
...
// These client libraries are officially supported by Google. However, this
// library is considered complete and is in maintenance mode. ...
// When possible, we recommend using our newer
// [Cloud Client Libraries for Go](https://pkg.go.dev/cloud.google.com/go) ...
```

(The maintenance-mode notice the generator bakes in is itself a hint that this
family is the *legacy* one relative to GAPIC.)

License: `google-api-go-client` is **BSD-3-Clause** (distinct from the rest of
the family).

---

## 4. Node.js and Java — also statically generated from Discovery Documents

### `google-api-nodejs-client` (the `googleapis` npm package)

`googleapis/google-api-nodejs-client` generates **TypeScript** clients under
`src/apis/<api>/<version>.ts`, one file per API/version, via an in-repo TS
generator (`src/generator/generator.ts`) driven by **Nunjucks templates**
(`src/generator/templates/*.njk`). `generator.md` states it directly:

> The clients in this repository are all automatically generated. They are
> generated using the [Google Discovery Service]. [...] `npm run generate` [...]
> will download all discovery files available via the discovery index
> (`https://www.googleapis.com/discovery/v1/apis/`), and run the code generator
> against those files.

`generator.ts` reads the downloaded discovery docs from a local `discovery/`
dir + `index.json` and calls `generateAPI(apiDiscoveryUrl)` per API; the
template `src/generator/templates/api-endpoint.njk` renders the namespace and
methods (`export namespace {{api.name}}_{{api.version}}` ...). A generated file
such as `src/apis/compute/v1.ts` carries the Apache license header and
`eslint-disable` banners emitted from `license.njk` / the template.

License: `google-api-nodejs-client` is **Apache-2.0**.

### Java — `google-api-java-client-services` (generated) vs. `google-api-java-client` (runtime)

Java splits into two repos:

- **`google-api-java-client`** — the hand-written **core runtime** library
  (`google-api-client`, plus transport/json adapter modules
  `google-api-client-gson`, `google-api-client-jackson2`, `-android`,
  `-appengine`, etc.). Apache-2.0. This is *not* generated; it provides the
  request/auth/transport plumbing that generated services depend on.

- **`google-api-java-client-services`** — the **generated** per-API services
  (`clients/google-api-services-<api>/<version>/<libver>/com/google/api/services/...`).
  A generated `Compute.java` header makes the provenance explicit:

  ```java
  /*
   * This code was generated by https://github.com/googleapis/google-api-java-client-services/
   * Modify at your own risk.
   */
  package com.google.api.services.compute;
  ```

  The generator itself is vendored in `generator/` and its `README` identifies it
  as the **Google APIs Code Generator** (`https://github.com/google/apis-client-generator/`),
  a **template-driven Python** tool: *"a tool for generating client libraries
  from Google APIs Discovery documents. It builds a rich (but language neutral)
  model of the API and then invokes a language specific backend to emit the
  library. The language generators are template driven."* Its `generate.sh`
  takes `<path/to/discovery.json> <output-directory>` and pip-installs the
  Python generator. This same generator (`google/apis-client-generator`, also
  vendored historically as `google-api-client-generator` in
  discovery-artifact-manager, now marked **deprecated** there) has backends for
  Java, C++, C#, PHP, Dart, etc. — i.e. it is the shared static generator behind
  several of the non-Go, non-JS targets.

Licenses: `google-api-java-client-services`, `google-api-java-client`, and
`google/apis-client-generator` are all **Apache-2.0**.

---

## 5. The contrast worth highlighting

**Same input, two strategies — and two families.**

Within the Discovery family, every language consumes the *same* Discovery
Documents, but:

| Language | Strategy | Generator / runtime | Per-API source committed? |
| --- | --- | --- | --- |
| **Python** (`google-api-python-client`) | **Runtime-dynamic** (boto3-like) | `googleapiclient.discovery.build` → `createMethod` / `Resource` build objects at runtime | **No** (only bundled static discovery JSON + 3rd-party type stubs) |
| **Go** (`google-api-go-client`) | **Static codegen** | `google-api-go-generator` (`gen.go`, Go) | **Yes** (`*-gen.go`, `DO NOT EDIT`) |
| **Node/TS** (`google-api-nodejs-client`) | **Static codegen** | in-repo TS generator + Nunjucks templates | **Yes** (`src/apis/*/*.ts`) |
| **Java** (`google-api-java-client-services`) | **Static codegen** | `google/apis-client-generator` (template-driven Python) | **Yes** (`com/google/api/services/...`) |

Python's data-driven model is the direct GCP analogue to AWS's
boto3/botocore: a hand-written runtime engine + JSON API models, no generated
per-service classes. Go/Node/Java instead bake the discovery doc into committed
source ahead of time.

**This whole family vs. the modern GAPIC/proto family.** Everything above is
driven by **Discovery Documents (REST/JSON)**. The newer GCP SDK family is
driven by **protobuf service definitions** (`googleapis/googleapis`) compiled by
the **GAPIC** generators (`gapic-generator-go`, `gapic-generator-python`, etc.)
into the `cloud.google.com/go/...` and `google-cloud-*` libraries, typically
speaking **gRPC** (with REST/JSON fallback). The generated Go discovery clients
even tell you so in their own banner ("we recommend using our newer Cloud Client
Libraries for Go"). Rule of thumb: hundreds of breadth-covering REST APIs →
Discovery family; the curated, actively-iterated Cloud product clients → GAPIC
family.

---

## Gaps / `?? verify`

- The discovery-doc shape and `kind: discovery#restDescription` were confirmed
  against the live doc (`compute.v1.json`) and the Discovery Service reference
  page. The exact internal sync mechanism that updates the `discoveries/` cache
  is "internal" per the README and not publicly inspectable — **`?? verify`** if
  a precise cadence/source is needed.
- The Node generator's per-method rendering was confirmed at the template level
  (`api-endpoint.njk` + `generator.ts` reading the discovery index); I did not
  trace every helper. A generated `DO NOT EDIT`-style marker was **not** found in
  the Node `.ts` output (only the Apache header + eslint-disable banners) —
  **`?? verify`** whether a stronger "generated" marker exists elsewhere.
- `apis-client-generator` is the static generator wired into the Java services
  repo's `generator/`; I confirmed it is template-driven Python with Java/C#/PHP/
  Dart/C++ backends via its `README`, but did not enumerate which *currently
  shipping* non-Java libraries still use it vs. bespoke generators.

---

## Links

**Discovery Service / source of truth**
- Discovery REST API reference: https://developers.google.com/discovery/v1/reference/apis
- discovery-artifact-manager README: https://github.com/googleapis/discovery-artifact-manager/blob/2c68f5855887c1e32368f9a22d05d785821783b0/README.md
- `discoveries/compute.v1.json` (cached discovery doc): https://github.com/googleapis/discovery-artifact-manager/blob/2c68f5855887c1e32368f9a22d05d785821783b0/discoveries/compute.v1.json
- LICENSE (Apache-2.0): https://github.com/googleapis/discovery-artifact-manager/blob/2c68f5855887c1e32368f9a22d05d785821783b0/LICENSE

**Python (runtime-dynamic)**
- `googleapiclient/discovery.py` (build / build_from_document / createMethod / Resource): https://github.com/googleapis/google-api-python-client/blob/6e471c075039dfef24e28d11658e03d5c949c7c3/googleapiclient/discovery.py
- `build()`: https://github.com/googleapis/google-api-python-client/blob/6e471c075039dfef24e28d11658e03d5c949c7c3/googleapiclient/discovery.py#L193
- `createMethod()`: https://github.com/googleapis/google-api-python-client/blob/6e471c075039dfef24e28d11658e03d5c949c7c3/googleapiclient/discovery.py#L1076
- `class Resource`: https://github.com/googleapis/google-api-python-client/blob/6e471c075039dfef24e28d11658e03d5c949c7c3/googleapiclient/discovery.py#L1402
- `_add_basic_methods` (dynamic attach): https://github.com/googleapis/google-api-python-client/blob/6e471c075039dfef24e28d11658e03d5c949c7c3/googleapiclient/discovery.py#L1501
- Third-party type stubs: https://github.com/henribru/google-api-python-client-stubs

**Go (statically generated)**
- `google-api-go-generator/gen.go`: https://github.com/googleapis/google-api-go-client/blob/3855346eda7f4ba6c844d86de5de493d3e395f00/google-api-go-generator/gen.go
- `GenerateCode()` header emission (`Code generated file. DO NOT EDIT.`): https://github.com/googleapis/google-api-go-client/blob/3855346eda7f4ba6c844d86de5de493d3e395f00/google-api-go-generator/gen.go#L800-L805
- Generated client `compute/v1/compute-gen.go` (DO NOT EDIT banner): https://github.com/googleapis/google-api-go-client/blob/3855346eda7f4ba6c844d86de5de493d3e395f00/compute/v1/compute-gen.go
- LICENSE (BSD-3-Clause): https://github.com/googleapis/google-api-go-client/blob/3855346eda7f4ba6c844d86de5de493d3e395f00/LICENSE

**Node / TypeScript (statically generated)**
- `generator.md`: https://github.com/googleapis/google-api-nodejs-client/blob/9e92f535023f86df98d8a9dcbdf7777434e3124f/generator.md
- `src/generator/generator.ts`: https://github.com/googleapis/google-api-nodejs-client/blob/9e92f535023f86df98d8a9dcbdf7777434e3124f/src/generator/generator.ts
- Template `src/generator/templates/api-endpoint.njk`: https://github.com/googleapis/google-api-nodejs-client/blob/9e92f535023f86df98d8a9dcbdf7777434e3124f/src/generator/templates/api-endpoint.njk
- Generated `src/apis/compute/v1.ts`: https://github.com/googleapis/google-api-nodejs-client/blob/9e92f535023f86df98d8a9dcbdf7777434e3124f/src/apis/compute/v1.ts
- LICENSE (Apache-2.0): https://github.com/googleapis/google-api-nodejs-client/blob/9e92f535023f86df98d8a9dcbdf7777434e3124f/LICENSE

**Java (statically generated + handwritten runtime)**
- Services README: https://github.com/googleapis/google-api-java-client-services/blob/2eb69439e022e15bfb494ed78500d4b356939b9d/README.md
- `generator/README` (Google APIs Code Generator): https://github.com/googleapis/google-api-java-client-services/blob/2eb69439e022e15bfb494ed78500d4b356939b9d/generator/README
- `generator/generate.sh` (`<discovery.json> <output-dir>`): https://github.com/googleapis/google-api-java-client-services/blob/2eb69439e022e15bfb494ed78500d4b356939b9d/generator/generate.sh
- Generated `Compute.java` ("This code was generated by ..."): https://github.com/googleapis/google-api-java-client-services/blob/2eb69439e022e15bfb494ed78500d4b356939b9d/clients/google-api-services-compute/v1/2.0.0/com/google/api/services/compute/Compute.java
- Core runtime repo `google-api-java-client`: https://github.com/googleapis/google-api-java-client/tree/81fc9f59601f15d89801721773864addb2ed9c7d
- LICENSE (Apache-2.0): https://github.com/googleapis/google-api-java-client-services/blob/2eb69439e022e15bfb494ed78500d4b356939b9d/LICENSE

**Shared template-driven generator**
- `google/apis-client-generator` README (Google APIs Code Generator): https://github.com/google/apis-client-generator/blob/f09f0ba855c3845d315b811c6234fd3996f33172/README
- LICENSE (Apache-2.0): https://github.com/google/apis-client-generator/blob/f09f0ba855c3845d315b811c6234fd3996f33172/LICENSE

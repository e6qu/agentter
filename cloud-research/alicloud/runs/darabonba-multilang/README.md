# Alibaba local generator run — one Darabonba source → Python + Go

**Result: SUCCESS** for Python and Go from a single `.dara` module. The single
most illustrative Alibaba run: it shows the *cross-language* property directly —
one DSL source compiled to two idiomatic SDKs.

## Toolchain
- Node 26 / npm 11
- `@darabonba/cli` 1.2.0 + `@darabonba/python-generator` + `@darabonba/go-generator`
  (the CLI dispatches to per-language generators, as documented in
  `alicloud/notes.md` §2 via `commands/codegen.js`'s `generatorMap`).

## Input (a hand-authored minimal module — see `input/`)
- `main.dara` — one `model Greeting` (a data shape) + one `static function build`
  (imperative logic written *in the DSL*).
- `Darafile` — the JSON project descriptor (the local analogue of the
  per-service `Teafile` in `aliyun/alibabacloud-sdk`).

A minimal self-contained module was used deliberately: real service modules
(e.g. `fc-20230330/main.tea`) `extends OpenApi` and import `Util`/`OpenApi`/etc.,
which require `dara install` to pull dependency modules from the Darabonba
registry. The minimal module isolates the generator behaviour without that
network dependency.

## Invocation
```
npx dara check  main.dara          # syntax check  -> "Check success!"
npx dara codegen go     out-go     .
npx dara codegen python out-python .
```

## What was generated (output/)
From the *same* `main.dara`:
- **Go** (`out-go/client/client.go` + `out-go/go.mod`): a `Greeting` struct with
  `json`/`xml` field tags and `require:"true"`, fluent `SetMessage`/`SetCount`
  setters, `String()/GoString()` via `tea.Prettify`, and the `Build` function.
- **Python** (`out-python/demo_greeter/{client,models}.py`): a `Client` class
  with the static `build` method and a `models.py` for `Greeting`.

Both carry the header `// This file is auto-generated, don't edit it. Thanks.` /
`# This file is auto-generated, don't edit it. Thanks.` — exactly the marker
cited in `alicloud/notes.md` §3.

## Evidence it reflects the documented architecture
- **One DSL → many languages.** The same source produced both SDKs; the DSL
  comments became per-language doc comments. This is the core Darabonba claim.
- **Generated code depends on the hand-written Tea runtime.** The Go output
  imports `github.com/alibabacloud-go/tea/tea` — i.e. the generated client sits
  on the hand-written runtime library, the generated-vs-handwritten boundary
  described in `CODE_GENERATION.md` (Alibaba §Customization).
- **Customization = code in the spec.** The `build` function body (imperative
  logic) was translated faithfully into both languages, demonstrating Alibaba's
  "write logic directly in `.tea`" customization mechanism rather than
  out-of-band templates/directives.

## Notes / debugging surfaced (documented, not papered over)
- The go-generator crashes (`TypeError: pack.map is not a function`) if the
  Darafile puts a **string** `package` under the `go` block — it expects
  `option.package` to be an array of imports. Fix: omit `go.package`; supply the
  Go module path via `releases.go` (`github.com/.../client:vX`) and the struct
  name via `go.clientName`.
- The python-generator rejects a non-snake-case `clientName`
  ("python clientName is must be snake case"). Fix: `python.clientName: "client"`
  (or omit → defaults to `client` with a warning).

## Takeaway for the deliverable
Darabonba is a genuine compiler: a single imperative DSL module deterministically
emits idiomatic Python and Go SDKs that bind to a shared hand-written runtime —
the clearest demonstration of the "one spec, N languages" property among the five
providers, because the spec here is executable rather than declarative.

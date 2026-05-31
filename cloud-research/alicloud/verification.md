# Alibaba Cloud — Cross-Language Verification of Darabonba SDKs

Research date: 2026-05-30. All permalinks pinned to commit SHAs captured this date.

Key SHAs used (this doc):
- `aliyun/darabonba` (the `@darabonba/parser` source + DSL docs) @ `932fe401f4e87dbc1971d623f0070a7831ee67bf`
- `aliyun/darabonba-cli` @ `f08154d89ab1f72f8d67aeb71043aa97423b643d`
- `aliyun/darabonba-assert` @ `240d74281a974f93337161157841de494d180eba`
- `aliyun/darabonba-string` @ `983bdbeff5f11ab26cf218d0df540bce3dec9606`
- `aliyun/darabonba-python-generator` @ `744354d7818c496dc8341d3f0044f59320118c16`
- `aliyun/darabonba-typescript-generator` @ `5510adc11452b8321e37f7350208e3e2d8b9164f`
- `aliyun/darabonba-php-generator` @ `9b3542cbec1543b6e3b30b7333ac0c4107f57741`
- `aliyun/darabonba-go-generator` @ `618f9f6e4fc77024b5916c41c7d660bed9308e5a`
- `aliyun/tea-python` (runtime, `darabonba-core`) @ `926e34f8d30f76d094a0af8050ec2c5024416199`
- `alibabacloud-go/tea` (Go runtime) @ `3ae6caaf9cdc16438749ae0566609aed5ace7737`
- `aliyun/credentials-go` @ `bebc5929aa42137285c9b03313a5cd926c547bb7`

---

## TL;DR

There is **no single, centralized, spec-driven cross-language conformance suite**
that proves all Darabonba-generated SDKs behave identically. What exists instead is
a set of partial, overlapping mechanisms:

1. **A real test-generation feature in the toolchain.** A Darabonba module's Darafile
   can declare a `test` entry pointing at a `*_test.tea` / `*_test.dara` module written
   in the same DSL. `dara codegen` will, *for the generators that opt in*, compile that
   one test module into a per-language test suite — exactly mirroring how the SDK itself
   is generated. This is genuine "one `.dara` test module → per-language test suites".
   **BUT** only three generators advertise the capability (Python, TypeScript, PHP via
   `static get supportGenerateTest()`), and in practice even repos that *have* a
   `test` Darafile entry ship a mix of generated and hand-written per-language tests.
2. **No `darabonba-test` / `tea-test` runtime repo exists.** The cross-language test
   primitives are instead a normal Darabonba *library*, `aliyun/darabonba-assert`
   (`Assert.equal` / `mapEql` / `arrayEql` / `contains`), which is itself generated to
   every language and used inside the generated test modules.
3. **The hand-written runtime libs** (`tea-python`/`darabonba-core`, `alibabacloud-go/tea`,
   `credentials-*`) are tested with **idiomatic, hand-written, per-language unit tests** —
   not spec-driven, not shared across languages.
4. **Each language generator carries its own golden-file fixtures** (`tests/fixtures/*`
   → `tests/expected/*`). The fixture *names* are parallel across generators
   (`annotation`, `api`, `builtin`, `comment`, `complex`, `model`, `import`, …) — a
   de-facto shared concept set — but the fixture *contents have diverged* (different blob
   SHAs per generator), so this is not one source-of-truth corpus.
5. `dara check` is single-file **syntax parsing only**; `dara score` is a
   **documentation/annotation/release-completeness linter**. Neither performs
   cross-language behavioural validation.

So Alibaba's cross-language guarantee rests mostly on **a single deterministic codegen
pipeline** (one `.dara` → all languages, so behaviour is "consistent by construction")
plus per-language hand-written runtime tests, rather than on an executed cross-language
conformance test matrix.

---

## Q1. Does Darabonba generate Test Cases from the DSL? (README claim)

**The README claim is real and verifiable.** `aliyun/darabonba`'s README (Chinese)
states the DSL can be used to generate, *for arbitrary-style interfaces*,
"多语言的 SDK、代码示例、测试用例、接口编排" — "multi-language SDKs, code samples,
**test cases**, interface orchestration".
Source: `aliyun/darabonba` `/blob/932fe401f4e87dbc1971d623f0070a7831ee67bf/README.md` (line 18).

There is **no separate test spec format**. A test case is just a normal Darabonba
module of `static function test*()` blocks, selected via a **`test` key in the Darafile**
(analogous to the `main` key that points at the SDK module). Evidence chain:

**(a) The CLI dispatches a second codegen pass for the test module.**
`commands/codegen.js` first generates from `pkg.main`, then:
```js
if (pkg.test && Generator.supportGenerateTest) {
  // generate from test dara code
  generateCode({ pkg, rootDir, outputDir, lang, testFile: true, daraFile: pkg.test });
}
```
Source: `aliyun/darabonba-cli` `/blob/f08154d89ab1f72f8d67aeb71043aa97423b643d/commands/codegen.js`.

**(b) Generators opt in via `supportGenerateTest`, and re-target output when `testFile: true`.**
The TypeScript generator constructor:
```js
static get supportGenerateTest() { return true; }
...
clientPath: option.testFile === true ? 'test/client.spec.ts' : 'src/client.ts',
```
and it writes a `mocha`/`nyc` test script into `package.json`.
Source: `aliyun/darabonba-typescript-generator`
`/blob/5510adc11452b8321e37f7350208e3e2d8b9164f/lib/generator.js` (lines 40-49, 124-125).
The Python generator (`/blob/744354d.../lib/generator.js`, line 22) and PHP generator
(`/blob/9b3542c.../lib/generator.js`) also expose `static get supportGenerateTest()`.
The **Go, Java, Java-async, C#, C++ generators do NOT** define `supportGenerateTest`
at the captured SHAs (so `dara codegen` skips the test pass for them).

**(c) Concrete example — `darabonba-assert` (the assertion library itself).**
Its Darafile declares both `main` and `test`:
```json
"main": "./assert.tea",
"test": "./assert_test.tea",
```
Source: `aliyun/darabonba-assert` `/blob/240d74281a974f93337161157841de494d180eba/Teafile`.

`assert_test.tea` is plain Darabonba — `static function testEqual()/testFail()/testMapEql()/testArrayEql()`
calling `Assert.equal(...)` etc.:
```
import Assert;
static function testEqual(): void { Assert.equal("A", "A", ""); }
static function testMapEql(): void { var a: map[string]number = { A = 1 }; ... Assert.mapEql(a, b, ""); }
```
Source: `aliyun/darabonba-assert` `/blob/240d74281a974f93337161157841de494d180eba/assert_test.tea`.

The **generated Python** test suite mirrors those functions one-for-one
(`test_equal`, `test_fail`, `test_map_eql`, `test_array_eql`, with DSL `mapEql` →
snake_case `map_eql`):
Source: `aliyun/darabonba-assert` `/blob/240d74281a974f93337161157841de494d180eba/python/tests/test_client.py`.

**Important nuance (the consistency story is uneven).** Within the *same* `darabonba-assert`
repo, only the Python suite looks generated. The Go suite is hand-written Go
(`utils.AssertNil`, Go-specific error-trace string assertions, includes a `TestContains`
not present in `assert_test.tea`):
Source: `aliyun/darabonba-assert` `/blob/240d74281a974f93337161157841de494d180eba/golang/client/client_test.go`.
The TS suite is hand-written mocha + `expect.js` (`describe`/`it`, hand-authored cases),
structurally unlike the DSL test module:
Source: `aliyun/darabonba-assert` `/blob/240d74281a974f93337161157841de494d180eba/ts/test/index.spec.ts`.

So: the *mechanism* to compile one `.dara` test module to per-language suites is real and
in the shipping CLI, but it is **not uniformly applied** — many per-language test files are
hand-maintained even when a generated path exists.

---

## Q2. A cross-language test framework (`darabonba-test` / Tea test runtime)?

**There is no dedicated `darabonba-test`, `tea-test`, or `darabonba-testing` repo**
under `aliyun` (all three 404 at research time).

The cross-language test *primitive* is instead an ordinary Darabonba **library**,
`aliyun/darabonba-assert` (module `darabonba:Assert`), which — like the SDK and like
`darabonba-openapi` — is authored once in `.tea` (`assert.tea`) and generated/published
to every language. Its Darafile `releases` map shows the per-language packages:
```
"ts":     "@darabonba/assert",
"java":   "com.aliyun:tea-assert",
"csharp": "AlibabaCloud.TeaAssert",
"go":     "github.com/alibabacloud-go/darabonba-assert/client",
"php":    "alibabacloud/darabonba-assert",
"python": "alibabacloud_tea_assert",
"cpp":    "alibabacloud-sdk-cpp/dara-assert"
```
Source: `aliyun/darabonba-assert` `/blob/240d74281a974f93337161157841de494d180eba/Teafile`.

So the model is: a `*_test.tea` module `import Assert;` and uses `Assert.equal/mapEql/...`;
generators that support tests compile that module to per-language suites; the generated
suites call the per-language build of `Assert`. This **mirrors the SDK generation model
exactly** (one DSL source → many languages, calling a generated cross-language runtime).
But it is a *capability*, not a maintained org-wide conformance matrix: it lives or dies
per-repo on whether the maintainers set a `test` Darafile entry and whether the target
language's generator implements `supportGenerateTest`.

---

## Q3. How are the hand-written runtime libs tested — shared or per-language?

**Per-language, hand-written, not spec-driven.**

- `aliyun/tea-python` (published as `darabonba-core`) ships a `tests/` tree of
  hand-written `unittest` modules: `test_core.py`, `test_runtime.py`, `test_request.py`,
  `test_model.py`, `test_date.py`, `test_url.py`, `policy/test_retry.py`, etc.
  Source: `aliyun/tea-python` `/tree/926e34f8d30f76d094a0af8050ec2c5024416199/tests`.
- `alibabacloud-go/tea` (Go runtime, package `dara`) ships idiomatic Go `*_test.go`:
  `dara/core_test.go`, `dara/array_test.go`, `dara/map_test.go`, `dara/model_test.go`,
  `dara/retry_test.go`, `dara/json_parser_test.go`, etc.
  Source: `alibabacloud-go/tea` `/tree/3ae6caaf9cdc16438749ae0566609aed5ace7737/dara`.
- `aliyun/credentials-go` ships Go `*_test.go` per provider:
  `credentials/credential_test.go`, `ecs_ram_role_credentials_provider_test.go`,
  `env_provider_test.go`, `internal/http/http_test.go`, etc.
  Source: `aliyun/credentials-go` `/tree/bebc5929aa42137285c9b03313a5cd926c547bb7/credentials`.

These runtimes are themselves hand-written per language (not generated), so their tests
are hand-written too. No shared spec / fixture drives them across languages.
`?? verify`: whether credentials-* across languages share a common JSON test-config /
golden vector (a known pattern in some SDK families) — not confirmed at the captured
SHAs; the visible Go tests are self-contained. Added to DO_NEXT.

**Contrast — a Darabonba *library* with no `test` Darafile entry still has per-language
tests, all hand-written.** `darabonba-string` has only `main.tea` (no `*_test.tea`) and
no `"test"` key in its Teafile, yet ships `python/tests/test_client.py`,
`golang/client/client_test.go`, `java/.../ClientTest.java`, `php/tests/StringTest.php`,
`csharp/tests/StringUtilTest.cs`, `ts/...`. Because there is no `test` Darafile entry,
none of these can be the codegen output — they are maintained by hand per language.
Source: `aliyun/darabonba-string`
`/blob/983bdbeff5f11ab26cf218d0df540bce3dec9606/Teafile` (no `test` key; only `main`),
and `/tree/983bdbeff5f11ab26cf218d0df540bce3dec9606` (single `main.tea`).

---

## Q4. Do `dara check` / `dara score` do cross-language validation/linting?

**No. Neither touches other languages or codegen output.**

- **`dara check <filename.dara>`** = single-file **syntax check only**. It reads one file
  and calls `Darabonba.parse(source, filePath)`; on success prints "Check success!".
  No semantic cross-module/cross-language analysis, no generation.
  Source: `aliyun/darabonba-cli`
  `/blob/f08154d89ab1f72f8d67aeb71043aa97423b643d/commands/check.js`.

- **`dara score`** = a **documentation / metadata completeness linter** for one package.
  It loads the Darafile, requires `scope`/`name`/`version`, then computes a weighted
  score from three axes — `readme`, `release`, `annotation` — and prints tables of
  "incomplete_APIs / functions / models" with their "missing_items", plus a list of
  "Unreleased Languages" (i.e. languages present in the codebase but missing from the
  Darafile `releases` map). That "Unreleased Languages" report is the closest thing to a
  cross-language check, but it only verifies *that a release coordinate is declared per
  language* — it does **not** generate, build, run, or compare behaviour across languages.
  Source: `aliyun/darabonba-cli`
  `/blob/f08154d89ab1f72f8d67aeb71043aa97423b643d/commands/score.js`.

The DSL parser itself has no `test`/`assert` keyword — assertions come from the `Assert`
*library*, confirming there is no language-level test/conformance construct.
Source: `aliyun/darabonba` `/blob/932fe401f4e87dbc1971d623f0070a7831ee67bf/lib/keyword.js`,
`/blob/932fe401f4e87dbc1971d623f0070a7831ee67bf/lib/parser.js` (no `test`/`assert` tokens).

---

## Generator golden-file tests (a related, partial cross-language signal)

Each language generator validates *itself* with golden-file fixtures: an input
`tests/fixtures/<case>/main.dara` is generated and diffed against
`tests/expected/<case>/...`. Cases include `annotation`, `api`, `builtin`, `comment`,
`complex`, `const`, `function`, `import`, `model`, `alias`, `empty`, …
Sources:
- Python: `aliyun/darabonba-python-generator`
  `/tree/744354d7818c496dc8341d3f0044f59320118c16/tests/fixtures` and `/tests/expected`.
- TypeScript: `aliyun/darabonba-typescript-generator`
  `/tree/5510adc11452b8321e37f7350208e3e2d8b9164f/test/fixtures`.
- Go: `aliyun/darabonba-go-generator`
  `/tree/618f9f6e4fc77024b5916c41c7d660bed9308e5a/test/fixtures`.

The fixture *names/concepts are parallel* across the three generators (a de-facto shared
case set), **but the fixture contents have diverged**: the `annotation/main.dara` blob has
a different git SHA in each repo —
TS `618251996e23e91fad5639c3723efbdddecfbd97`,
Go `9f07b8f961066398e9809159c625819bc01d1c17`,
Python `b14e5751dd5baf002ebbd355db73e51c979d972b`.
So this is **per-generator self-testing with cloned-but-drifted inputs**, not a single
shared cross-language golden corpus. It guards "does generator X still emit the expected
idiomatic code for case Y", which indirectly supports consistency, but does not *execute*
the generated SDKs or compare runtime behaviour across languages.

---

## Gaps / `?? verify`

- `?? verify` — whether any **executed cross-language conformance matrix** exists in CI
  (e.g. a job that generates the same module to N languages, builds them, and runs a
  shared behavioural suite). Not found in the toolchain; the `supportGenerateTest`
  mechanism is the only generation-side hook and is unevenly adopted. Likely lives (if
  anywhere) in internal Alibaba CI not mirrored to GitHub.
- `?? verify` — whether `credentials-*` libs share a common golden test-vector / JSON
  config across languages.
- `?? verify` — the exact list of generators that implement `supportGenerateTest` at
  their *latest* tagged releases (checked: py/ts/php = yes; go/java/java-async/cs/cpp = no,
  at captured SHAs).

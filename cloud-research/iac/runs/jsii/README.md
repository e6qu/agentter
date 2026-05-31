# Build: jsii — author once in TypeScript, transpile to many languages

**Result: SUCCESS.** A minimal TypeScript construct was compiled by **jsii** into a
language-agnostic `.jsii` assembly and then transpiled by **jsii-pacmak** into a
Python package. This is the engine behind **AWS CDK**, **CDKTF**, and **cdk8s**.

## Toolchain
- Node 26 (jsii prints an "untested node version" warning; silenced via
  `JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=1`)
- `jsii` 5.9.43 + `jsii-pacmak` (installed as **devDependencies** — if installed
  as runtime `dependencies`, jsii tries to resolve `jsii` itself as a jsii module
  and fails)
- Python 3 (target for pacmak)

## Input (`input/`)
- `index.ts` — one `interface GreeterProps` + one `class Greeter` with a `greet()`
  method (the "jsii-compatible subset": behaviour-free `readonly` props struct,
  behavioural class, no overloads/generics).
- `package.json` — the `jsii` config block (`outdir`, `targets.python`,
  `targets.java`).

## Commands (`cmd.sh`)
```
npm install -D jsii jsii-pacmak
npx jsii                 # compile TS + emit the .jsii assembly (the type model)
npx jsii-pacmak -t python # transpile the assembly -> Python wheel/sdist
```

## Output (`output/`)
- `assembly.jsii.json` — the `.jsii` assembly (`schema: jsii/0.10.0`), the
  language-agnostic type model: fqns `greeting-construct.Greeter`,
  `greeting-construct.GreeterProps`.
- `python-src/` — the generated Python package (extracted from the produced sdist).

## The key evidence (what makes jsii distinctive)
The generated Python `Greeter.greet()` is **not reimplemented in Python**. In
`output/python-src/greeting_construct/__init__.py`:
```python
class Greeter(metaclass=jsii.JSIIMeta, jsii_type="greeting-construct.Greeter"):
    def greet(self) -> builtins.str:
        return typing.cast(builtins.str, jsii.invoke(self, "greet", []))
```
The Python class is a **thin proxy**: `jsii.invoke(...)` marshals the call over a
bridge into the original **TypeScript logic running in a Node "kernel" process**.
One real implementation (TS); every other language is a generated façade. This is
how AWS publishes a single `aws-cdk-lib` to Python/Java/.NET/Go.

## Contrast (see also `../pulumi/`)
jsii = **author-once, transpile to proxies over one runtime**. Pulumi =
**generate N real, self-contained SDKs from a schema**. Same goal, opposite
mechanics. See `../README.md` for the side-by-side.

## Takeaway
A working reproduction of the jsii model end-to-end (TS → `.jsii` assembly →
Python proxy package), with no AWS/CDK-specific tooling — the generic engine that
the entire jsii CDK family is built on.

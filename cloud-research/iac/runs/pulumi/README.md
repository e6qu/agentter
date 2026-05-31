# Build: Pulumi — one Package Schema → per-language SDKs

**Result: SUCCESS.** From a single `schema.json` (a Pulumi Package Schema),
`pulumi package gen-sdk` generated a **Python** SDK *and* a **Go** SDK — each
idiomatic and self-contained. This is the per-language-codegen model (the same
shape as the cloud SDKs in `../../../CODE_GENERATION.md`).

## Toolchain
- Pulumi CLI 3.244.0 (`brew install pulumi`)
- Python 3 / Go 1.26 (targets)

## Input (`input/`)
- `schema.json` — a minimal **Pulumi Package Schema**: one component resource
  `greeting:index:Greeter` with an input `name` and an output `message`, plus the
  `language: { python, go, nodejs }` bag. For real cloud providers this schema is
  emitted by **pulumi-terraform-bridge** `tfgen` from the upstream Terraform
  provider's schema, or natively from Azure OpenAPI / Google Discovery docs.

## Commands (`cmd.sh`)
```
pulumi package gen-sdk schema.json --language python -o out
pulumi package gen-sdk schema.json --language go     -o out
```

## Output (`output/`)
From the *same* schema, two real SDKs:
- `python/pulumi_greeting/{greeter,provider,__init__}.py` —
  `class Greeter(pulumi.ComponentResource)`, `GreeterArgs`.
- `go/greeting/{greeter,provider,init,doc}.go` — `type Greeter struct`,
  `func NewGreeter(ctx, name, args, ...)`.

## The key evidence (contrast with jsii)
Unlike jsii (`../jsii/`), the generated code is **not** a proxy into another
runtime — each language gets a genuine, native implementation. `greeter.py`
defines a real `pulumi.ComponentResource` subclass; `greeter.go` defines a real
struct + constructor with `pulumi.StringOutput` fields. **N targets by N codegen
backends**, sharing only the schema — exactly the model the cloud-provider SDKs
use, applied to infrastructure resources.

## Note
When not logged in, the `pulumi` CLI auto-created an *ephemeral cloud account* and
its output asked to relay an account-claim URL. `pulumi package gen-sdk` codegen is
fully **local/offline** and needs no account; the prompt was a non-actionable CLI
side effect and was ignored.

## Takeaway
A working reproduction of Pulumi's schema → per-language SDK pipeline, and the
clearest live contrast to jsii's transpile-to-proxies approach.

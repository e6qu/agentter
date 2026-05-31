# GCP local generator run — Cloud Functions v2 → Python

**Result: SUCCESS.** `gapic-generator-python` produced a complete Python client
library (63 files, ~22,190 LOC) from a single annotated `.proto`.

## Toolchain
- Python 3.13.13 in a `uv` venv
- `gapic-generator` (PyPI), `grpcio-tools` (provides `protoc` via
  `python -m grpc_tools.protoc`), `googleapis-common-protos`
- **pandoc 3.9.0.2** — a genuine hard dependency: gapic-generator-python uses
  `pypandoc` to convert proto-comment documentation into Python docstrings.
  Without pandoc the plugin fails with `OSError: No pandoc was found` and
  `protoc-gen-python_gapic: Plugin failed with status code 1`. (First run hit
  exactly this; installing pandoc fixed it.)

## Input (spec)
- `googleapis/googleapis` @ `0054cdcbd8ea44298f329d916d8173dd736fbaaa`
  - `google/cloud/functions/v2/functions.proto` (the API surface)
  - `google/cloud/functions/v2/cloudfunctions_v2.yaml` (service config, passed
    as `service-yaml`)
  - common deps: `google/api/*`, `google/longrunning`, `google/rpc`, `google/type`
- Both input files pinned under `input/`.

## Invocation
See `cmd.sh`. The core call:
```
python -m grpc_tools.protoc -I . \
  --plugin=protoc-gen-python_gapic="$(which protoc-gen-python_gapic)" \
  --python_gapic_out=output \
  --python_gapic_opt="transport=grpc+rest,service-yaml=.../cloudfunctions_v2.yaml" \
  google/cloud/functions/v2/functions.proto
```
Note: this reproduces what a `py_gapic_library` Bazel target does, but invoked
directly via `protoc` — no Bazel needed. The GAPIC generator is a standard
`protoc` plugin discovered through the `protoc-gen-python_gapic` console script.

## What was generated (output/)
A full idiomatic library, not just stubs:
- `services/function_service/{client,async_client}.py` — sync + async clients
- `services/function_service/transports/{grpc,grpc_asyncio,rest,rest_base}.py`
  — both gRPC and REST transports (because `transport=grpc+rest`)
- `services/function_service/pagers.py` — pagination helpers
- `types/functions.py` — proto-plus message wrappers
- `samples/generated_samples/*.py` — one runnable sample per RPC
- `tests/unit/...`, `docs/`, `noxfile.py`, `setup.py`, `testing/constraints-*.txt`

## Evidence it reflects the documented architecture
- **Proto annotations drive codegen.** `functions.proto` declares
  `option (google.api.method_signature) = "name"` on `GetFunction`; the
  generated `client.py:745` has the flattened overload `name: Optional[str] = None`,
  i.e. `client.get_function(name=...)` rather than only
  `get_function(request=...)`. This is the annotation→ergonomic-overload
  mechanism described in `CODE_GENERATION.md` (GCP §Customization).
- **Engine = Jinja2.** The generator is the Jinja2-templated
  `gapic-generator-python` (per `gcp/notes.md` §2).
- **GAPIC_AUTO.** Cloud Functions ships as pure-generated (no handwritten
  wrapper); this run is the whole public client surface, consistent with the
  `library_type: GAPIC_AUTO` finding.

## Takeaway for the deliverable
One annotated proto + service-yaml, run through a `protoc` plugin, deterministically
yields a complete multi-transport Python client — the cleanest demonstration of the
GCP "spec (protobuf+annotations) → per-language generator" pipeline.

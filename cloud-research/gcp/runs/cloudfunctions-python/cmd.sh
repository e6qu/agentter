#!/usr/bin/env bash
# GCP — gapic-generator-python against Cloud Functions v2.  Reproducible run.
set -euo pipefail

# 1. Python env (3.13; 3.14 also works). protoc comes from grpcio-tools.
uv venv --python 3.13 gcp-venv
source gcp-venv/bin/activate
uv pip install gapic-generator grpcio-tools googleapis-common-protos
# 2. pandoc is a REAL dependency (gapic-generator-python converts proto-comment
#    docs to docstrings via pypandoc). Without it the plugin exits 1.
brew install pandoc   # or pypandoc.download_pandoc()

# 3. Protos: sparse, blobless shallow clone of googleapis @ 0054cdcb
git clone --depth 1 --filter=blob:none --sparse https://github.com/googleapis/googleapis.git
cd googleapis
git sparse-checkout set google/cloud/functions/v2 google/api google/longrunning google/rpc google/type

# 4. Generate. The gapic plugin is discovered via the protoc-gen-python_gapic console script.
python -m grpc_tools.protoc \
  -I . \
  --plugin=protoc-gen-python_gapic="$(which protoc-gen-python_gapic)" \
  --python_gapic_out=OUTPUT_DIR \
  --python_gapic_opt="transport=grpc+rest,service-yaml=google/cloud/functions/v2/cloudfunctions_v2.yaml" \
  google/cloud/functions/v2/functions.proto

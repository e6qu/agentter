#!/usr/bin/env bash
# Azure LEGACY path — AutoRest (Swagger 2.0 -> Python).  Reproducible run.
set -euo pipefail
npm install autorest
# AutoRest self-downloads its core (@autorest/core) + the @autorest/python plugin
# + @autorest/modelerfour at runtime.  It prints a live deprecation notice
# ("AutoRest is deprecated and will be retired on July 1, 2026").
npx autorest --python \
  --input-file=widgets.json \
  --output-folder=out-python \
  --namespace=widgetservice

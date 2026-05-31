#!/usr/bin/env bash
# Alibaba — Darabonba: one .dara DSL source -> Python AND Go.  Reproducible run.
set -euo pipefail
npm install @darabonba/cli @darabonba/python-generator @darabonba/go-generator
# project = Darafile (JSON config) + main.dara (the module).  See input/.
npx dara check main.dara                 # syntax check
npx dara codegen go     out-go     .     # DSL -> Go
npx dara codegen python out-python .     # DSL -> Python
# Notes on the Darafile shape (learned by debugging the generators):
#  - releases.go "github.com/.../client:vX" supplies the Go module path (go.mod).
#  - go.clientName sets the struct name; do NOT put a string `package` under `go`
#    (the go-generator treats option.package as an array of imports -> crashes).
#  - python.clientName must be snake_case (or omitted -> defaults to "client").

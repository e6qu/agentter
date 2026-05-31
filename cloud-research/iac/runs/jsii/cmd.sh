#!/usr/bin/env bash
# jsii — author once in TypeScript, transpile to many languages. Reproducible run.
set -euo pipefail
export JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=1   # node 26 is newer than jsii's tested set
npm install -D jsii jsii-pacmak     # MUST be devDependencies, not dependencies
npx jsii                            # compile TS + emit the .jsii assembly (the type model)
npx jsii-pacmak -t python           # transpile the assembly -> Python wheel/sdist
# (-t java / dotnet / go also available; Python shown here)

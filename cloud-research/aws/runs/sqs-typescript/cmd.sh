#!/usr/bin/env bash
# AWS — Smithy codegen: SQS Smithy model -> TypeScript client.  Reproducible run.
set -euo pipefail
# Toolchain: JDK (Smithy CLI bundles its own runtime) + Smithy CLI.
brew install smithy-lang/tap/smithy-cli         # -> smithy 1.71.0

# Input model: the real SQS Smithy 2.0 JSON AST from api-models-aws @ fd819cad.
SHA=fd819cad3147ee122087ef83ea092bd32309c5c8
mkdir -p model
curl -sL "https://raw.githubusercontent.com/aws/api-models-aws/$SHA/models/sqs/service/2012-11-05/sqs-2012-11-05.json" -o model/sqs.json

# smithy-build.json pulls the AWS TS codegen from Maven Central and selects the
# typescript-client-codegen plugin for service com.amazonaws.sqs#AmazonSQS.
smithy build
# Output: build/smithy/source/typescript-client-codegen/src/...

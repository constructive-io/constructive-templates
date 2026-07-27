#!/usr/bin/env bash
# codegen.sh — run GraphQL SDK codegen without clobbering the project README.
#
# @constructive-io/graphql-codegen unconditionally writes a generated
# "GraphQL SDK" README.md at the project root for multi-target configs
# (generateRootRootReadme has no opt-out). Our README.md is hand-written
# documentation, so preserve it across the run.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PRESERVE="$(mktemp)"
cp README.md "$PRESERVE"
restore() { cp "$PRESERVE" README.md; rm -f "$PRESERVE"; }
trap restore EXIT

rm -rf ./src/graphql/sdk/admin ./src/graphql/sdk/auth ./src/graphql/sdk/app
npx @constructive-io/graphql-codegen generate --config ./graphql-codegen.config.ts "$@"

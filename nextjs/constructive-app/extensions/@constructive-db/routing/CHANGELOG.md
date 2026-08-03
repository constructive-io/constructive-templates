# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# [5.2.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/routing@5.0.0...@constructive-db/routing@5.2.0) (2026-08-01)

### Features

- sync extension metadata to package.json versions + lerna version lifecycle + CI version-consistency check ([506c718](https://github.com/constructive-io/constructive-platform/commit/506c71844fde030280109de64417d15f45c5f434))
- upstream regenerated platform modules (stored physical bucket coordinate, target_service_id, catalog buckets sync) + bundle artifacts ([1351507](https://github.com/constructive-io/constructive-platform/commit/1351507958326cae52c9e948126e6652420ad970)), closes [constructive-db#2621](https://github.com/constructive-db/issues/2621) [#2630](https://github.com/constructive-io/constructive-platform/issues/2630)

# [5.0.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/routing@3.0.0...@constructive-db/routing@5.0.0) (2026-07-27)

- feat!: restrict published modules to schema+grants with cherry-picked resolvers and catalog-sync triggers ([0d88492](https://github.com/constructive-io/constructive-platform/commit/0d884925dc1457effa3595fc95bfe6fc8e9720a6))

### BREAKING CHANGES

- internal procedures removed from published packages.

# [3.0.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/routing@1.0.1...@constructive-db/routing@3.0.0) (2026-07-27)

### Bug Fixes

- refresh modules with uppercase grant verify privileges; own external [@pgpm](https://github.com/pgpm) ranges here ([d72d4a6](https://github.com/constructive-io/constructive-platform/commit/d72d4a67ea395ba24065b67617006f23debf0942))

- feat!: upstream the logical-name control-plane modules from constructive-db ([96425e0](https://github.com/constructive-io/constructive-platform/commit/96425e0b2c5e4fb83c04efce0750951cb530e7cf))

### BREAKING CHANGES

- @constructive-db/{catalog,routing,apps} now create the
  logical schema names (catalog_public, routing_public, apps_public/private)
  instead of the constructive_*-prefixed ones. constructive-routing-functions
  is removed (resolve_route/resolve_http_route/api_schema_names now ship in
  the routing/routing-platform modules).

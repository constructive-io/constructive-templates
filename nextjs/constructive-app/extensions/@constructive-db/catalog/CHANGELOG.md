# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# [5.1.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@5.0.0...@constructive-db/catalog@5.1.0) (2026-08-10)

### Features

- upstream regenerated platform modules (scope plane, email identities, content presets, capabilities rename) ([25f7e9e](https://github.com/constructive-io/constructive-platform/commit/25f7e9e46fa7cd4f38b4aa2bac29fc67655b1c6a))

# [5.0.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@4.6.0...@constructive-db/catalog@5.0.0) (2026-08-05)

- feat!: publish the catalog plane as catalog_private ([40fd7b0](https://github.com/constructive-io/constructive-platform/commit/40fd7b04a5e1fec4c4c7c14ee0b7c3441076578f))

### BREAKING CHANGES

- @constructive-db/catalog creates catalog_private instead of catalog_public, and the tg_*_catalog_sync/_catalog_del trigger fns and their attachments in every base module move with it. Upgrading an install: deploy the new module, re-register the scoped source tables (which backfills the projection), then drop catalog_public. Consumers naming catalog_public in SQL must be updated in lockstep.

# [4.6.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@4.5.0...@constructive-db/catalog@4.6.0) (2026-08-05)

### Features

- upstream regenerated platform modules (queue behaviour, bucket tags, anonymous surface) ([034561c](https://github.com/constructive-io/constructive-platform/commit/034561cf475cba383be9b1ebbd66a8c9e8559ab8)), closes [constructive-io/constructive-db#2783](https://github.com/constructive-io/constructive-db/issues/2783) [#2784](https://github.com/constructive-io/constructive-platform/issues/2784)

# [4.5.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@4.4.0...@constructive-db/catalog@4.5.0) (2026-08-03)

### Features

- upstream regenerated platform modules (serving_lane, realm, installation-backed sites, strict routing names) ([0da8065](https://github.com/constructive-io/constructive-platform/commit/0da8065e4e6cc71e46a72f0c59260863ef2936cb)), closes [constructive-io/constructive-db#2684](https://github.com/constructive-io/constructive-db/issues/2684) [#2689](https://github.com/constructive-io/constructive-platform/issues/2689) [#2690](https://github.com/constructive-io/constructive-platform/issues/2690) [#2701](https://github.com/constructive-io/constructive-platform/issues/2701) [#2703](https://github.com/constructive-io/constructive-platform/issues/2703)

# [4.4.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@4.2.0...@constructive-db/catalog@4.4.0) (2026-08-02)

### Features

- upstream sites front-door + merkle-backed pages platform modules ([ffd73b9](https://github.com/constructive-io/constructive-platform/commit/ffd73b915322d54f95c97f1807a0acbdf7ecd084)), closes [constructive-io/constructive-db#2667](https://github.com/constructive-io/constructive-db/issues/2667) [#2680](https://github.com/constructive-io/constructive-platform/issues/2680) [#2682](https://github.com/constructive-io/constructive-platform/issues/2682) [#2684](https://github.com/constructive-io/constructive-platform/issues/2684)

# [4.2.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@4.0.0...@constructive-db/catalog@4.2.0) (2026-08-01)

### Features

- sync extension metadata to package.json versions + lerna version lifecycle + CI version-consistency check ([506c718](https://github.com/constructive-io/constructive-platform/commit/506c71844fde030280109de64417d15f45c5f434))
- upstream regenerated platform modules (stored physical bucket coordinate, target_service_id, catalog buckets sync) + bundle artifacts ([1351507](https://github.com/constructive-io/constructive-platform/commit/1351507958326cae52c9e948126e6652420ad970)), closes [constructive-db#2621](https://github.com/constructive-db/issues/2621) [#2630](https://github.com/constructive-io/constructive-platform/issues/2630)

# [4.0.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@3.0.0...@constructive-db/catalog@4.0.0) (2026-07-27)

- feat!: restrict published modules to schema+grants with cherry-picked resolvers and catalog-sync triggers ([0d88492](https://github.com/constructive-io/constructive-platform/commit/0d884925dc1457effa3595fc95bfe6fc8e9720a6))

### BREAKING CHANGES

- internal procedures removed from published packages.

# [3.0.0](https://github.com/constructive-io/constructive-platform/compare/@constructive-db/catalog@1.0.1...@constructive-db/catalog@3.0.0) (2026-07-27)

### Bug Fixes

- refresh modules with uppercase grant verify privileges; own external [@pgpm](https://github.com/pgpm) ranges here ([d72d4a6](https://github.com/constructive-io/constructive-platform/commit/d72d4a67ea395ba24065b67617006f23debf0942))

- feat!: upstream the logical-name control-plane modules from constructive-db ([96425e0](https://github.com/constructive-io/constructive-platform/commit/96425e0b2c5e4fb83c04efce0750951cb530e7cf))

### BREAKING CHANGES

- @constructive-db/{catalog,routing,apps} now create the
  logical schema names (catalog_public, routing_public, apps_public/private)
  instead of the constructive_*-prefixed ones. constructive-routing-functions
  is removed (resolve_route/resolve_http_route/api_schema_names now ship in
  the routing/routing-platform modules).

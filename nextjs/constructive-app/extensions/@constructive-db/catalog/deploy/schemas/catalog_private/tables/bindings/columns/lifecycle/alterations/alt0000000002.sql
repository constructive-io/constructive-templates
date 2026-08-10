-- Deploy: schemas/catalog_private/tables/bindings/columns/lifecycle/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/columns/lifecycle/column


COMMENT ON COLUMN catalog_private.bindings.lifecycle IS 'Lifecycle the binding applies to (deployment/execution/root_execution), propagated from the source row';
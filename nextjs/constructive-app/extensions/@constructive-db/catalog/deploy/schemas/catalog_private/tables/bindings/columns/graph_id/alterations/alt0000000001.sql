-- Deploy: schemas/catalog_private/tables/bindings/columns/graph_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/columns/graph_id/column


COMMENT ON COLUMN catalog_private.bindings.graph_id IS 'Flow graph holding the binding, propagated from the source row';
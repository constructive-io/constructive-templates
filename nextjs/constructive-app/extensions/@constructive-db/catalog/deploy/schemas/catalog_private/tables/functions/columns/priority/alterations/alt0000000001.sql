-- Deploy: schemas/catalog_private/tables/functions/columns/priority/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/columns/priority/column


COMMENT ON COLUMN catalog_private.functions.priority IS 'Job priority (lower = higher priority), propagated from the source definition';
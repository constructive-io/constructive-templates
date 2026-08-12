-- Deploy: schemas/catalog_private/tables/functions/columns/max_attempts/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/columns/max_attempts/column


COMMENT ON COLUMN catalog_private.functions.max_attempts IS 'Maximum retry attempts, propagated from the source definition';
-- Deploy: schemas/catalog_private/tables/functions/columns/queue_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/columns/queue_name/column


COMMENT ON COLUMN catalog_private.functions.queue_name IS 'Job queue name for serialization, propagated from the source definition';
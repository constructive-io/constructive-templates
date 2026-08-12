-- Deploy: schemas/catalog_private/tables/domains/columns/owner_scope/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/owner_scope/column


COMMENT ON COLUMN catalog_private.domains.owner_scope IS 'Scope of the source table that owns the row';
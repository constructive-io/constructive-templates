-- Deploy: schemas/catalog_public/tables/namespaces/columns/owner_scope/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/columns/owner_scope/column


COMMENT ON COLUMN catalog_public.namespaces.owner_scope IS 'Scope of the source table that owns the row';
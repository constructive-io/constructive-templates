-- Deploy: schemas/catalog_public/tables/namespaces/columns/namespace_name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/columns/namespace_name/column


COMMENT ON COLUMN catalog_public.namespaces.namespace_name IS 'Computed namespace slug; globally exclusive across all scopes';
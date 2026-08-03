-- Deploy: schemas/catalog_public/tables/resource_installations/columns/is_visible/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/columns/is_visible/column


COMMENT ON COLUMN catalog_public.resource_installations.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';
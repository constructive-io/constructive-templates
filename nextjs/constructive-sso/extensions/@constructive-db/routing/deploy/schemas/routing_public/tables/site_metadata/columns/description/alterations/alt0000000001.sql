-- Deploy: schemas/routing_public/tables/site_metadata/columns/description/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/columns/description/column


COMMENT ON COLUMN routing_public.site_metadata.description IS 'Meta description (max 120 characters)';
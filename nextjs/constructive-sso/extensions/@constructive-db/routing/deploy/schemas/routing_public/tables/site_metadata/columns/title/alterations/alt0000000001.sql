-- Deploy: schemas/routing_public/tables/site_metadata/columns/title/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/columns/title/column


COMMENT ON COLUMN routing_public.site_metadata.title IS 'Meta title (max 120 characters)';
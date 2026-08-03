-- Deploy: schemas/routing_public/tables/platform_site_metadata/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/id/column


ALTER TABLE routing_public.platform_site_metadata 
  ALTER COLUMN id SET NOT NULL;
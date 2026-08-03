-- Deploy: schemas/routing_public/tables/platform_site_modules/columns/site_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_modules/table
-- requires: schemas/routing_public/tables/platform_site_modules/columns/site_id/column


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN site_id SET NOT NULL;
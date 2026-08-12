-- Deploy: schemas/routing_public/tables/platform_site_metadata/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/updated_at/column


ALTER TABLE routing_public.platform_site_metadata 
  ALTER COLUMN updated_at SET DEFAULT now();
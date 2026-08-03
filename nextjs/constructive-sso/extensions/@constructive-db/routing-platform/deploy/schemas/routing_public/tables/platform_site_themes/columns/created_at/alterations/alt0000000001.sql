-- Deploy: schemas/routing_public/tables/platform_site_themes/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table
-- requires: schemas/routing_public/tables/platform_site_themes/columns/created_at/column


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN created_at SET DEFAULT now();
-- Deploy: schemas/routing_public/tables/platform_site_themes/columns/name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table
-- requires: schemas/routing_public/tables/platform_site_themes/columns/name/column


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN name SET DEFAULT 'default';
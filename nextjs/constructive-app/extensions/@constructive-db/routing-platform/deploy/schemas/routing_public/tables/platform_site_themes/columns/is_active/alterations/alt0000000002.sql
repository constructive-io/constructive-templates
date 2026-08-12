-- Deploy: schemas/routing_public/tables/platform_site_themes/columns/is_active/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table
-- requires: schemas/routing_public/tables/platform_site_themes/columns/is_active/column


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN is_active SET DEFAULT false;
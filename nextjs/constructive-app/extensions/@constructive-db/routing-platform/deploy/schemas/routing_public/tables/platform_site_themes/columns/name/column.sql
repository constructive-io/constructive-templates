-- Deploy: schemas/routing_public/tables/platform_site_themes/columns/name/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table


ALTER TABLE routing_public.platform_site_themes 
  ADD COLUMN name text;
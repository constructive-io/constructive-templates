-- Deploy: schemas/routing_public/tables/platform_site_modules/columns/name/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_modules/table


ALTER TABLE routing_public.platform_site_modules 
  ADD COLUMN name text;
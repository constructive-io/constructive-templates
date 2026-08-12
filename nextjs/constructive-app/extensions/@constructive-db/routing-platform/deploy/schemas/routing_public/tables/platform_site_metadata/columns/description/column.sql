-- Deploy: schemas/routing_public/tables/platform_site_metadata/columns/description/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table


ALTER TABLE routing_public.platform_site_metadata 
  ADD COLUMN description text;
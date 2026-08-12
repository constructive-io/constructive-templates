-- Deploy: schemas/routing_public/tables/platform_site_themes/constraints/platform_site_themes_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/routing_public/tables/platform_site_themes/table


ALTER TABLE routing_public.platform_site_themes 
  ADD CONSTRAINT platform_site_themes_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.platform_sites (id)
    ON DELETE CASCADE;
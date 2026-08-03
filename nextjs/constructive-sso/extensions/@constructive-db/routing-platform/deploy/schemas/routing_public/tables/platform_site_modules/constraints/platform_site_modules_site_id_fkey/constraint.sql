-- Deploy: schemas/routing_public/tables/platform_site_modules/constraints/platform_site_modules_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/routing_public/tables/platform_site_modules/table


ALTER TABLE routing_public.platform_site_modules 
  ADD CONSTRAINT platform_site_modules_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.platform_sites (id)
    ON DELETE CASCADE;
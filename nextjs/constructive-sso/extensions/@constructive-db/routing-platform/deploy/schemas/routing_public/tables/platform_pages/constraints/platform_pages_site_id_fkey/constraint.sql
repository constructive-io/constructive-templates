-- Deploy: schemas/routing_public/tables/platform_pages/constraints/platform_pages_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table
-- requires: schemas/routing_public/tables/platform_sites/table


ALTER TABLE routing_public.platform_pages 
  ADD CONSTRAINT platform_pages_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.platform_sites (id)
    ON DELETE CASCADE;
-- Deploy: schemas/routing_public/tables/pages/constraints/pages_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.pages 
  ADD CONSTRAINT pages_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;
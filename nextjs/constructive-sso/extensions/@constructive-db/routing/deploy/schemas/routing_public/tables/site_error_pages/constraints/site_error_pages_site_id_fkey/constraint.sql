-- Deploy: schemas/routing_public/tables/site_error_pages/constraints/site_error_pages_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/site_error_pages/table


ALTER TABLE routing_public.site_error_pages 
  ADD CONSTRAINT site_error_pages_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;
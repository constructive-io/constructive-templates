-- Deploy: schemas/routing_public/tables/site_metadata/constraints/site_metadata_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/site_metadata/table


ALTER TABLE routing_public.site_metadata 
  ADD CONSTRAINT site_metadata_site_id_fkey
    FOREIGN KEY(site_id)
    REFERENCES routing_public.sites (id)
    ON DELETE CASCADE;
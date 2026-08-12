-- Deploy: schemas/routing_public/tables/routes/constraints/routes_target_site_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/routing_public/tables/routes/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_site_id_fkey
    FOREIGN KEY(target_site_id)
    REFERENCES catalog_private.sites (id)
    ON DELETE CASCADE;
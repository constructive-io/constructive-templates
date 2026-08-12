-- Deploy: schemas/routing_public/tables/sites/constraints/sites_resource_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/catalog_private/tables/resources/table


ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_resource_id_fkey
    FOREIGN KEY(resource_id)
    REFERENCES catalog_private.resources (id)
    ON DELETE CASCADE;
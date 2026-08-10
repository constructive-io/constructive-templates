-- Deploy: schemas/routing_public/tables/platform_sites/constraints/platform_sites_installation_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/catalog_private/tables/resource_installations/table


ALTER TABLE routing_public.platform_sites 
  ADD CONSTRAINT platform_sites_installation_id_fkey
    FOREIGN KEY(installation_id)
    REFERENCES catalog_private.resource_installations (id)
    ON DELETE RESTRICT;
-- Deploy: schemas/platform_routing_public/tables/platform_routes/constraints/platform_routes_target_service_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/platform_routing_public/schema
-- requires: schemas/catalog_private/tables/resources/table
-- requires: schemas/platform_routing_public/tables/platform_routes/table


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_target_service_id_fkey
    FOREIGN KEY(target_service_id)
    REFERENCES catalog_private.resources (id)
    ON DELETE CASCADE;
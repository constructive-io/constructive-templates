-- Deploy: schemas/platform_routing_public/tables/platform_routes/constraints/platform_routes_target_api_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/platform_routing_public/schema
-- requires: schemas/catalog_private/tables/apis/table
-- requires: schemas/platform_routing_public/tables/platform_routes/table


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_target_api_id_fkey
    FOREIGN KEY(target_api_id)
    REFERENCES catalog_private.apis (id)
    ON DELETE CASCADE;
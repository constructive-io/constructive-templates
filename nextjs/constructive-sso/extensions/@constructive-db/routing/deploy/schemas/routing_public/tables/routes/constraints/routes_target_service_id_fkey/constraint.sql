-- Deploy: schemas/routing_public/tables/routes/constraints/routes_target_service_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_service_id_fkey
    FOREIGN KEY(target_service_id)
    REFERENCES catalog_public.resources (id)
    ON DELETE CASCADE;
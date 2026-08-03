-- Deploy: schemas/routing_public/tables/sites/constraints/sites_database_id_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_database_id_name_key 
    UNIQUE (database_id, name);
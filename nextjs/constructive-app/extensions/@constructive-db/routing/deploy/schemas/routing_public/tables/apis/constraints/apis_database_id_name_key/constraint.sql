-- Deploy: schemas/routing_public/tables/apis/constraints/apis_database_id_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table


ALTER TABLE routing_public.apis 
  ADD CONSTRAINT apis_database_id_name_key 
    UNIQUE (database_id, name);
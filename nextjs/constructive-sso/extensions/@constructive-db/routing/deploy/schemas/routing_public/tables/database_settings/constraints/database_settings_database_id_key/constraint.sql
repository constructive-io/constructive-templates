-- Deploy: schemas/routing_public/tables/database_settings/constraints/database_settings_database_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table


ALTER TABLE routing_public.database_settings 
  ADD CONSTRAINT database_settings_database_id_key 
    UNIQUE (database_id);
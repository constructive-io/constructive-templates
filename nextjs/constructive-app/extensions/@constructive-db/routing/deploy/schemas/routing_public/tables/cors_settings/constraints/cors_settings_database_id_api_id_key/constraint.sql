-- Deploy: schemas/routing_public/tables/cors_settings/constraints/cors_settings_database_id_api_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table


ALTER TABLE routing_public.cors_settings 
  ADD CONSTRAINT cors_settings_database_id_api_id_key 
    UNIQUE (database_id, api_id);
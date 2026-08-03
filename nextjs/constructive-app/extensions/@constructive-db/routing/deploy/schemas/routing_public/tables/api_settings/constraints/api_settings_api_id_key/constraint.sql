-- Deploy: schemas/routing_public/tables/api_settings/constraints/api_settings_api_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table


ALTER TABLE routing_public.api_settings 
  ADD CONSTRAINT api_settings_api_id_key 
    UNIQUE (api_id);
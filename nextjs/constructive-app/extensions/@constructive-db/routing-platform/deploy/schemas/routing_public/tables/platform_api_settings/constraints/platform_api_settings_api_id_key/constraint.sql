-- Deploy: schemas/routing_public/tables/platform_api_settings/constraints/platform_api_settings_api_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_settings/table


ALTER TABLE routing_public.platform_api_settings 
  ADD CONSTRAINT platform_api_settings_api_id_key 
    UNIQUE (api_id);
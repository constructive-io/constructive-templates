-- Deploy: schemas/routing_public/tables/platform_cors_settings/constraints/platform_cors_settings_api_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table
-- requires: schemas/routing_public/tables/platform_cors_settings/table


ALTER TABLE routing_public.platform_cors_settings 
  ADD CONSTRAINT platform_cors_settings_api_id_fkey
    FOREIGN KEY(api_id)
    REFERENCES routing_public.platform_apis (id)
    ON DELETE CASCADE;
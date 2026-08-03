-- Deploy: schemas/routing_public/tables/cors_settings/constraints/cors_settings_api_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/routing_public/tables/cors_settings/table


ALTER TABLE routing_public.cors_settings 
  ADD CONSTRAINT cors_settings_api_id_fkey
    FOREIGN KEY(api_id)
    REFERENCES routing_public.apis (id)
    ON DELETE CASCADE;
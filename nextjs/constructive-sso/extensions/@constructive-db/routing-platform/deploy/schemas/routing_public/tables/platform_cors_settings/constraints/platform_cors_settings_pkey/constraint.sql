-- Deploy: schemas/routing_public/tables/platform_cors_settings/constraints/platform_cors_settings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/table


ALTER TABLE routing_public.platform_cors_settings 
  ADD CONSTRAINT platform_cors_settings_pkey PRIMARY KEY (id);
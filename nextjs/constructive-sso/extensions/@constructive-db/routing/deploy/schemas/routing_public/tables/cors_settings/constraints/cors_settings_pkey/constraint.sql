-- Deploy: schemas/routing_public/tables/cors_settings/constraints/cors_settings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table


ALTER TABLE routing_public.cors_settings 
  ADD CONSTRAINT cors_settings_pkey PRIMARY KEY (id);
-- Deploy: schemas/routing_public/tables/rls_settings/constraints/rls_settings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table


ALTER TABLE routing_public.rls_settings 
  ADD CONSTRAINT rls_settings_pkey PRIMARY KEY (id);
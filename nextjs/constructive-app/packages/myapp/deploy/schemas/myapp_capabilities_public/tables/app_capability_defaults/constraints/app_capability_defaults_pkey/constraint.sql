-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/constraints/app_capability_defaults_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ADD CONSTRAINT app_capability_defaults_pkey PRIMARY KEY (id);


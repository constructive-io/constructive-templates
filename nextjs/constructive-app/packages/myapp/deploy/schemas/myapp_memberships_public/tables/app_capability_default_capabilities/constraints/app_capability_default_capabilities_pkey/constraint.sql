-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/constraints/app_capability_default_capabilities_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  ADD CONSTRAINT app_capability_default_capabilities_pkey PRIMARY KEY (id);


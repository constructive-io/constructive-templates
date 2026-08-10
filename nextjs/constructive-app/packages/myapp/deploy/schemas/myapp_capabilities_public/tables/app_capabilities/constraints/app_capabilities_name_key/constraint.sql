-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/constraints/app_capabilities_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table


ALTER TABLE myapp_capabilities_public.app_capabilities 
  ADD CONSTRAINT app_capabilities_name_key 
    UNIQUE (name);


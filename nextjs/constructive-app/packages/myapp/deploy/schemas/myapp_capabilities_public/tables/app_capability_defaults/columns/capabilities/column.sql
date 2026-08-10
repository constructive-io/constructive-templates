-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/capabilities/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ADD COLUMN capabilities bit(64);


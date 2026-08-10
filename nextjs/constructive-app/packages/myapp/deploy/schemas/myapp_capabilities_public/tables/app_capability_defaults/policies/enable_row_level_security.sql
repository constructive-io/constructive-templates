-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ENABLE ROW LEVEL SECURITY;


-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/policies/enable_row_level_security


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  DISABLE ROW LEVEL SECURITY;



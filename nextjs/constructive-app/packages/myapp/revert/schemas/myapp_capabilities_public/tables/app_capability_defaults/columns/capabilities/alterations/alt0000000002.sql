-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/capabilities/alterations/alt0000000002


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ALTER COLUMN capabilities DROP DEFAULT;



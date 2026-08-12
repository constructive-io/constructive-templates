-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/capabilities/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ALTER COLUMN capabilities DROP NOT NULL;



-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/id/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ALTER COLUMN id DROP NOT NULL;



-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/capabilities/column


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  DROP COLUMN capabilities RESTRICT;



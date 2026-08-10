-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/bitstr/column


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DROP COLUMN bitstr RESTRICT;



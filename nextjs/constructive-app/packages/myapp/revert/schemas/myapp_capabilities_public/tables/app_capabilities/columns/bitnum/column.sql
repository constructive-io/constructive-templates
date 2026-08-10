-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/bitnum/column


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DROP COLUMN bitnum RESTRICT;



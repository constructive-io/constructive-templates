-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/kind/column


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DROP COLUMN kind RESTRICT;



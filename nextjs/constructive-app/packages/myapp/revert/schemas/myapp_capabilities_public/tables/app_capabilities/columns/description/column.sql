-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/description/column


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DROP COLUMN description RESTRICT;



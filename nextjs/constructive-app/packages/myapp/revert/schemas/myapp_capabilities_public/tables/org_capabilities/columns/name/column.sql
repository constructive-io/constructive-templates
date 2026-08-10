-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/columns/name/column


ALTER TABLE myapp_capabilities_public.org_capabilities 
  DROP COLUMN name RESTRICT;



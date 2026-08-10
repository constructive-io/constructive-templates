-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitstr/column


ALTER TABLE myapp_capabilities_public.org_capabilities 
  DROP COLUMN bitstr RESTRICT;



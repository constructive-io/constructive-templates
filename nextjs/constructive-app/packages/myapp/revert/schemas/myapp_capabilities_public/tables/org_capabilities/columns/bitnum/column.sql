-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitnum/column


ALTER TABLE myapp_capabilities_public.org_capabilities 
  DROP COLUMN bitnum RESTRICT;



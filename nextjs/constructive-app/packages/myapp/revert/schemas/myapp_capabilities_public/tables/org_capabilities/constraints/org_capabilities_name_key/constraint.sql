-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/constraints/org_capabilities_name_key/constraint


ALTER TABLE myapp_capabilities_public.org_capabilities 
  DROP CONSTRAINT org_capabilities_name_key;



-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/capabilities/column


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  DROP COLUMN capabilities RESTRICT;



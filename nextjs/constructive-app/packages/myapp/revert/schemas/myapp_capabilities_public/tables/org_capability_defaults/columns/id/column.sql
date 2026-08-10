-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/id/column


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  DROP COLUMN id RESTRICT;



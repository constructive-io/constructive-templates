-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/column


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  DROP COLUMN entity_id RESTRICT;



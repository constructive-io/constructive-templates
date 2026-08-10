-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/constraints/org_capability_defaults_entity_id_fkey/constraint


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  DROP CONSTRAINT org_capability_defaults_entity_id_fkey;



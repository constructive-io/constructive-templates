-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  ALTER COLUMN entity_id DROP NOT NULL;



-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/entity_id/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  ALTER COLUMN entity_id DROP NOT NULL;



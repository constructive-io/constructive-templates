-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/updated_at/column


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  DROP COLUMN updated_at RESTRICT;



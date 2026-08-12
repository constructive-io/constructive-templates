-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/capability_id/column


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  DROP COLUMN capability_id RESTRICT;



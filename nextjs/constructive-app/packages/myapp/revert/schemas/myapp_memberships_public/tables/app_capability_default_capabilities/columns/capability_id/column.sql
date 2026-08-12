-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/capability_id/column


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  DROP COLUMN capability_id RESTRICT;



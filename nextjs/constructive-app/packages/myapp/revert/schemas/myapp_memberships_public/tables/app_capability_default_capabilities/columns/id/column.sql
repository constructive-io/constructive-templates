-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/id/column


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  DROP COLUMN id RESTRICT;



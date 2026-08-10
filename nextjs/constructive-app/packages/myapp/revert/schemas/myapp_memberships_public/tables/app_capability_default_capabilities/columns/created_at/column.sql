-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/created_at/column


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  DROP COLUMN created_at RESTRICT;



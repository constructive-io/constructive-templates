-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/capability_id/column


ALTER TABLE myapp_memberships_public.app_capability_default_grants 
  DROP COLUMN capability_id RESTRICT;



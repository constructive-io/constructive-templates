-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/id/column


ALTER TABLE myapp_memberships_public.app_capability_default_grants 
  DROP COLUMN id RESTRICT;



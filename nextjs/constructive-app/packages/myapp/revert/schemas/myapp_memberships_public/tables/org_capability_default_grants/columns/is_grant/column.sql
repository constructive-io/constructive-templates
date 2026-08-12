-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/is_grant/column


ALTER TABLE myapp_memberships_public.org_capability_default_grants 
  DROP COLUMN is_grant RESTRICT;



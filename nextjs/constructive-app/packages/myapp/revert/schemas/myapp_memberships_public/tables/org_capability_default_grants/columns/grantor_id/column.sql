-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/grantor_id/column


ALTER TABLE myapp_memberships_public.org_capability_default_grants 
  DROP COLUMN grantor_id RESTRICT;



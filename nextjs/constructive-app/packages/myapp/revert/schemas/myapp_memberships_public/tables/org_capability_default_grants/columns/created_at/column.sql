-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/created_at/column


ALTER TABLE myapp_memberships_public.org_capability_default_grants 
  DROP COLUMN created_at RESTRICT;



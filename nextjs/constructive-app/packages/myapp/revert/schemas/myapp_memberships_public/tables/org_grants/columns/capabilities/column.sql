-- Revert: schemas/myapp_memberships_public/tables/org_grants/columns/capabilities/column


ALTER TABLE myapp_memberships_public.org_grants 
  DROP COLUMN capabilities RESTRICT;



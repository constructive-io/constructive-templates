-- Revert: schemas/myapp_memberships_public/tables/org_memberships/columns/is_owner/alterations/alt0000000002


ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_owner DROP DEFAULT;



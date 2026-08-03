-- Revert: schemas/myapp_memberships_public/tables/org_memberships/columns/granted/alterations/alt0000000002


ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN granted DROP DEFAULT;



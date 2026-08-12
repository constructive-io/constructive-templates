-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/is_grant/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.org_capability_default_grants 
  ALTER COLUMN is_grant DROP NOT NULL;



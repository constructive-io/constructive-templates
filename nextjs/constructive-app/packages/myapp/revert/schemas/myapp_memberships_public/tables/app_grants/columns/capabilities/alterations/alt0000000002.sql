-- Revert: schemas/myapp_memberships_public/tables/app_grants/columns/capabilities/alterations/alt0000000002


ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN capabilities DROP DEFAULT;



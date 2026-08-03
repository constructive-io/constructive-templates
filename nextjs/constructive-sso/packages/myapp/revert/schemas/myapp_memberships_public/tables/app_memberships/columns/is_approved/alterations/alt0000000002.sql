-- Revert: schemas/myapp_memberships_public/tables/app_memberships/columns/is_approved/alterations/alt0000000002


ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_approved DROP DEFAULT;



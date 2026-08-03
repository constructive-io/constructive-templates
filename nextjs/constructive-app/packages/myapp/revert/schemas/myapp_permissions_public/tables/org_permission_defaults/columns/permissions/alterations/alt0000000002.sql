-- Revert: schemas/myapp_permissions_public/tables/org_permission_defaults/columns/permissions/alterations/alt0000000002


ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ALTER COLUMN permissions DROP DEFAULT;



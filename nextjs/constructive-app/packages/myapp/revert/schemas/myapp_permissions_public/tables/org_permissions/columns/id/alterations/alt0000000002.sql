-- Revert: schemas/myapp_permissions_public/tables/org_permissions/columns/id/alterations/alt0000000002


ALTER TABLE myapp_permissions_public.org_permissions 
  ALTER COLUMN id DROP DEFAULT;



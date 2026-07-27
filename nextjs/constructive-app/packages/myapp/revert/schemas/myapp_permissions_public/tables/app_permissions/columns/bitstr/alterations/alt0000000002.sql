-- Revert: schemas/myapp_permissions_public/tables/app_permissions/columns/bitstr/alterations/alt0000000002


ALTER TABLE myapp_permissions_public.app_permissions 
  ALTER COLUMN bitstr DROP DEFAULT;



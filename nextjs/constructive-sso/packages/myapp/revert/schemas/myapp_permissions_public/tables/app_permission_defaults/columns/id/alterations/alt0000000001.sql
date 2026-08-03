-- Revert: schemas/myapp_permissions_public/tables/app_permission_defaults/columns/id/alterations/alt0000000001


ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ALTER COLUMN id DROP NOT NULL;



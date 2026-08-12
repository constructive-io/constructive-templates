-- Revert: schemas/myapp_memberships_public/tables/app_memberships/columns/is_banned/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_banned DROP NOT NULL;



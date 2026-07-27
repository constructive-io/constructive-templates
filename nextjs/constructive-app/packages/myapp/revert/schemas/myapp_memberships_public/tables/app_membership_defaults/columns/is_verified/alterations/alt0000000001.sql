-- Revert: schemas/myapp_memberships_public/tables/app_membership_defaults/columns/is_verified/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN is_verified DROP NOT NULL;



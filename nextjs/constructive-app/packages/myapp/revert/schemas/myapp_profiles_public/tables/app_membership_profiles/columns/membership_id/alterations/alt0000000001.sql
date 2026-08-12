-- Revert: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/membership_id/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ALTER COLUMN membership_id DROP NOT NULL;



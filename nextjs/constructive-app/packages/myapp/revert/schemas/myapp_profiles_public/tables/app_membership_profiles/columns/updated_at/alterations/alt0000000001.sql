-- Revert: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ALTER COLUMN updated_at DROP DEFAULT;



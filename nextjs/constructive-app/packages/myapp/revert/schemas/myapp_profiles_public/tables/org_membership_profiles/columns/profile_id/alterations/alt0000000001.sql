-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/profile_id/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  ALTER COLUMN profile_id DROP NOT NULL;



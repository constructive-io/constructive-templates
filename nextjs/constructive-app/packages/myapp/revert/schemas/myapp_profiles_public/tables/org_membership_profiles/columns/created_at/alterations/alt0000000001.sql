-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  ALTER COLUMN created_at DROP DEFAULT;



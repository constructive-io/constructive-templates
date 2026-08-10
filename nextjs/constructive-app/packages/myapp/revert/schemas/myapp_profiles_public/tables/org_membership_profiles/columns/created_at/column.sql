-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/created_at/column


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  DROP COLUMN created_at RESTRICT;



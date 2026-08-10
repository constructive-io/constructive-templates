-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/updated_at/column


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  DROP COLUMN updated_at RESTRICT;



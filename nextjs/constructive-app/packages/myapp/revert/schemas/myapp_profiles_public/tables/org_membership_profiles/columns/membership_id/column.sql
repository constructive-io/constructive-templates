-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/membership_id/column


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  DROP COLUMN membership_id RESTRICT;



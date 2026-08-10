-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/constraints/org_membership_profiles_pkey/constraint


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  DROP CONSTRAINT org_membership_profiles_pkey;



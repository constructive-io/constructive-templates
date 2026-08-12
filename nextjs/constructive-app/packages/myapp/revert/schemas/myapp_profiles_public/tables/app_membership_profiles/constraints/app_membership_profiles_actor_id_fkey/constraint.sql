-- Revert: schemas/myapp_profiles_public/tables/app_membership_profiles/constraints/app_membership_profiles_actor_id_fkey/constraint


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  DROP CONSTRAINT app_membership_profiles_actor_id_fkey;



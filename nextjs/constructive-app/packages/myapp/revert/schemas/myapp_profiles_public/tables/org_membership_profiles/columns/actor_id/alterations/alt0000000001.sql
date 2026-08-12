-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/actor_id/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  ALTER COLUMN actor_id DROP NOT NULL;



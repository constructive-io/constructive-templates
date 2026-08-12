-- Deploy: schemas/myapp_profiles_private/trigger_fns/app_memberships_profiles_seed_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


CREATE FUNCTION myapp_profiles_private.app_memberships_profiles_seed_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.profile_id IS NOT NULL THEN
    INSERT INTO myapp_profiles_public.app_membership_profiles (
      membership_id,
      profile_id,
      actor_id
    )
    VALUES
      (NEW.id, NEW.profile_id, NEW.actor_id)
    ON CONFLICT (membership_id, profile_id) DO NOTHING;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


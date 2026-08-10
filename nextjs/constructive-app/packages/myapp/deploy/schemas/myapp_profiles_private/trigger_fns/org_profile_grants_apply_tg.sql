-- Deploy: schemas/myapp_profiles_private/trigger_fns/org_profile_grants_apply_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/org_profiles/table
-- requires: schemas/myapp_memberships_public/tables/org_memberships/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table


CREATE FUNCTION myapp_profiles_private.org_profile_grants_apply_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.is_grant IS TRUE AND NEW.profile_id IS NOT NULL THEN
    INSERT INTO myapp_profiles_public.org_membership_profiles (
      membership_id,
      profile_id,
      actor_id
    )
    VALUES
      (NEW.membership_id, NEW.profile_id, (SELECT m.actor_id
      FROM myapp_memberships_public.org_memberships AS m
      WHERE
          m.id = NEW.membership_id))
    ON CONFLICT (membership_id, profile_id) DO NOTHING;
  ELSIF NEW.is_grant IS FALSE THEN
    DELETE FROM myapp_profiles_public.org_membership_profiles
    WHERE
      membership_id = NEW.membership_id AND (NEW.profile_id IS NULL OR profile_id = NEW.profile_id);
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


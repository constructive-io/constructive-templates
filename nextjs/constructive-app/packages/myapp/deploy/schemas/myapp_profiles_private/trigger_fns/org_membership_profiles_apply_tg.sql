-- Deploy: schemas/myapp_profiles_private/trigger_fns/org_membership_profiles_apply_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_memberships_public/tables/org_memberships/table


CREATE FUNCTION myapp_profiles_private.org_membership_profiles_apply_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  UPDATE myapp_memberships_public.org_memberships SET
  profile_id = COALESCE(org_memberships.profile_id, NEW.profile_id)
  WHERE
    id = NEW.membership_id;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


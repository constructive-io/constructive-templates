-- Deploy: schemas/myapp_profiles_private/trigger_fns/org_profiles_cascade_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_memberships_public/tables/org_memberships/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table


CREATE FUNCTION myapp_profiles_private.org_profiles_cascade_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF OLD.capabilities IS DISTINCT FROM NEW.capabilities THEN
    UPDATE myapp_memberships_public.org_memberships SET
    profile_id = profile_id
    WHERE
      EXISTS (SELECT 1
      FROM myapp_profiles_public.org_membership_profiles AS mp
      WHERE
          mp.membership_id = org_memberships.id AND mp.profile_id = NEW.id);
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


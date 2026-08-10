-- Deploy: schemas/myapp_profiles_private/trigger_fns/org_memberships_profile_sync_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/org_profiles/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table


CREATE FUNCTION myapp_profiles_private.org_memberships_profile_sync_tg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_profile_capabilities bit(64);
BEGIN
  IF NEW.is_admin IS TRUE OR NEW.is_owner IS TRUE THEN
    RETURN NEW;
  END IF;
  v_profile_capabilities := (SELECT bit_or(p.capabilities)
  FROM myapp_profiles_public.org_profiles AS p
  WHERE
    EXISTS (SELECT 1
    FROM myapp_profiles_public.org_membership_profiles AS mp
    WHERE
        mp.membership_id = NEW.id AND mp.profile_id = p.id));
  IF v_profile_capabilities IS NOT NULL THEN
    NEW.capabilities := NEW.granted | v_profile_capabilities;
  ELSE
    NEW.capabilities := NEW.granted;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;


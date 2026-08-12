-- Deploy: schemas/myapp_memberships_private/trigger_fns/app_memberships_insert_sprt_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_private/tables/app_memberships_sprt/table


CREATE FUNCTION myapp_memberships_private.app_memberships_insert_sprt_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.is_owner IS true THEN
    NEW.is_admin := true;
    NEW.is_approved := true;
    NEW.is_verified := true;
    NEW.is_disabled := false;
    NEW.is_banned := false;
  END IF;
  NEW.is_active := ((NEW.is_approved IS true AND NEW.is_verified IS true) AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_active IS TRUE THEN
    INSERT INTO myapp_memberships_private.app_memberships_sprt (
      is_owner,
      is_admin,
      capabilities,
      actor_id
    )
    VALUES
      (NEW.is_owner, NEW.is_admin, CASE 
          WHEN (NEW.is_owner IS TRUE OR NEW.is_admin IS TRUE) AND (NEW.capabilities IS NULL OR NEW.capabilities = (lpad('', (bit_length(NEW.capabilities))::int, '0'))::pg_catalog.varbit) THEN (lpad('', (bit_length(NEW.capabilities))::int, '1'))::pg_catalog.varbit 
          ELSE NEW.capabilities 
        END, NEW.actor_id);
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


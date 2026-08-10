-- Deploy: schemas/myapp_memberships_private/trigger_fns/org_memberships_utg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema


CREATE FUNCTION myapp_memberships_private.org_memberships_utg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  bitlen int := bit_length(NEW.capabilities);
BEGIN
  IF NEW.is_owner IS true THEN
    NEW.is_admin := true;
    NEW.is_approved := true;
    NEW.is_disabled := false;
    NEW.is_banned := false;
    NEW.is_read_only := false;
  END IF;
  IF NEW.is_admin IS true THEN
    NEW.is_read_only := false;
  END IF;
  NEW.is_active := (NEW.is_approved IS true AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_admin IS true OR NEW.is_owner IS true THEN
    NEW.capabilities := lpad('', bitlen::int, '1');
  ELSE
    NEW.capabilities := NEW.granted;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


-- Deploy: schemas/myapp_memberships_private/trigger_fns/app_memberships_itg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_public/tables/app_memberships/table
-- requires: schemas/myapp_memberships_public/tables/app_membership_defaults/table
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


CREATE FUNCTION myapp_memberships_private.app_memberships_itg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  bitlen int := bit_length(NEW.capabilities);
  defaults bit varying;
  memdefs myapp_memberships_public.app_membership_defaults;
BEGIN
  SELECT *
  FROM myapp_memberships_public.app_membership_defaults AS t
  LIMIT
  1 INTO memdefs;
  IF FOUND THEN
    NEW.is_approved := memdefs.is_approved;
    NEW.is_verified := memdefs.is_verified;
  END IF;
  IF NEW.is_owner IS true THEN
    NEW.is_admin := true;
    NEW.is_approved := true;
    NEW.is_verified := true;
    NEW.is_disabled := false;
    NEW.is_banned := false;
  END IF;
  NEW.is_active := ((NEW.is_approved IS true AND NEW.is_verified IS true) AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  SELECT capabilities
  FROM myapp_capabilities_public.app_capability_defaults AS t
  LIMIT
  1 INTO defaults;
  IF NOT (FOUND) THEN
    NEW.granted := lpad('', bitlen::int, '0');
  ELSE
    NEW.granted := defaults;
  END IF;
  IF NEW.is_admin IS true OR NEW.is_owner IS true THEN
    NEW.capabilities := lpad('', bitlen::int, '1');
  ELSE
    NEW.capabilities := NEW.granted;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;


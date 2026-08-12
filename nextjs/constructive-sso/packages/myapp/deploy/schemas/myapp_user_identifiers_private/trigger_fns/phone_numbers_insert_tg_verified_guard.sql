-- Deploy: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_insert_tg_verified_guard
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_insert_tg_verified_guard() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF (OLD.is_primary IS FALSE AND NEW.is_primary IS TRUE) AND NEW.is_verified IS FALSE THEN
    RAISE EXCEPTION 'PRIMARY_REQUIRES_VERIFIED';
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;


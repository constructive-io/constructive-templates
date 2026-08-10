-- Deploy: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_number_e164_fn
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema


CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_number_e164_fn() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  NEW.number := regexp_replace(NEW.number, '[^+0-9]', '', 'g');
  IF NOT (NEW.number ~ '^\+') AND regexp_replace(COALESCE(NEW.cc, ''), '[^0-9]', '', 'g') <> '' THEN
    NEW.number := ('+' || regexp_replace(COALESCE(NEW.cc, ''), '[^0-9]', '', 'g')) || NEW.number;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;


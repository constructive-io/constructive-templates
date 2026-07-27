-- Deploy: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_insert_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_insert_tg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_primary_field myapp_user_identifiers_public.phone_numbers;
  v_other_exists boolean;
BEGIN
  SELECT *
  FROM myapp_user_identifiers_public.phone_numbers AS e
  WHERE
    e.owner_id = NEW.owner_id AND is_primary IS TRUE INTO v_primary_field;
  IF NOT (FOUND) THEN
    new.is_primary := true;
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_public.phone_numbers
    WHERE
      owner_id = NEW.owner_id
    LIMIT
    1) INTO v_other_exists;
  IF (NEW.is_primary IS TRUE AND NEW.is_verified IS FALSE) AND v_other_exists IS TRUE THEN
    RAISE EXCEPTION 'PRIMARY_REQUIRES_VERIFIED';
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;


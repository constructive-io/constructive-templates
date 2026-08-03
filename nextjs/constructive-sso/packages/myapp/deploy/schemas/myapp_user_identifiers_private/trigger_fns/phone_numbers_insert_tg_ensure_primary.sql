-- Deploy: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_insert_tg_ensure_primary
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_insert_tg_ensure_primary() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF OLD.is_primary IS TRUE THEN
    IF NOT (EXISTS (SELECT 1
    FROM myapp_user_identifiers_public.phone_numbers
    WHERE
      owner_id = OLD.owner_id AND is_primary IS TRUE
    LIMIT
    1)) THEN
      UPDATE myapp_user_identifiers_public.phone_numbers SET
      is_primary = true
      WHERE
        ctid = ((SELECT ctid
        FROM myapp_user_identifiers_public.phone_numbers
        WHERE
            owner_id = OLD.owner_id AND is_verified IS TRUE
        LIMIT
        1));
    END IF;
  END IF;
  RETURN NULL;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;


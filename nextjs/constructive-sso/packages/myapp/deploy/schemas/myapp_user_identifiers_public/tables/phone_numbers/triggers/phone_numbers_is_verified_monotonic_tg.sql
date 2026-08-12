-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/phone_numbers_is_verified_monotonic_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table


CREATE TRIGGER phone_numbers_is_verified_monotonic_tg
BEFORE UPDATE ON myapp_user_identifiers_public.phone_numbers
FOR EACH ROW
WHEN (OLD.is_verified IS TRUE AND NEW.is_verified IS FALSE)
EXECUTE PROCEDURE utils.throw ( 'MONOTONIC_FIELD', 'is_verified' );


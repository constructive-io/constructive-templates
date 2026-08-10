-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/triggers/phone_numbers_number_e164_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_number_e164_fn


CREATE TRIGGER phone_numbers_number_e164_tg
BEFORE INSERT ON myapp_user_identifiers_public.phone_numbers
FOR EACH ROW
EXECUTE PROCEDURE myapp_user_identifiers_private.phone_numbers_number_e164_fn ( );


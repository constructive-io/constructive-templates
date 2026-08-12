-- Verify: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_insert_tg


SELECT assert_function('myapp_user_identifiers_private.phone_numbers_insert_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



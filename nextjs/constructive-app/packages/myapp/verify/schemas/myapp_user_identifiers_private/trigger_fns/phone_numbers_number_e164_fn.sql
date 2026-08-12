-- Verify: schemas/myapp_user_identifiers_private/trigger_fns/phone_numbers_number_e164_fn


SELECT assert_function('myapp_user_identifiers_private.phone_numbers_number_e164_fn()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



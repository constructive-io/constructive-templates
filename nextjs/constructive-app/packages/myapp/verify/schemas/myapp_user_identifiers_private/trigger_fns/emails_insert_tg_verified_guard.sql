-- Verify: schemas/myapp_user_identifiers_private/trigger_fns/emails_insert_tg_verified_guard


SELECT assert_function('myapp_user_identifiers_private.emails_insert_tg_verified_guard()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



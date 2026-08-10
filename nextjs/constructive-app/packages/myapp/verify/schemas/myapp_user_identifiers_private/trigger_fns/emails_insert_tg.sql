-- Verify: schemas/myapp_user_identifiers_private/trigger_fns/emails_insert_tg


SELECT assert_function('myapp_user_identifiers_private.emails_insert_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



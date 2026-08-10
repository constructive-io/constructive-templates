-- Verify: schemas/myapp_auth_public/procedures/confirm_delete_account/procedure


SELECT assert_function('myapp_auth_public.confirm_delete_account(uuid, text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');



-- Verify: schemas/myapp_auth_public/procedures/disconnect_account/procedure


SELECT assert_function('myapp_auth_public.disconnect_account(uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');



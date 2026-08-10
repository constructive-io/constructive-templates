-- Verify: schemas/myapp_auth_public/procedures/approve_device/procedure


SELECT assert_function('myapp_auth_public.approve_device(text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');



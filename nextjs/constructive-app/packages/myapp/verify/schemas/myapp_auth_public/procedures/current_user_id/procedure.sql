-- Verify: schemas/myapp_auth_public/procedures/current_user_id/procedure


SELECT assert_function('myapp_auth_public.current_user_id()'::regprocedure, 'uuid'::regtype, false, false, 'STABLE');



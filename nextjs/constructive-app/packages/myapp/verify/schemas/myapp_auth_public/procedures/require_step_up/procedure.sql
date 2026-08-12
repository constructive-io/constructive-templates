-- Verify: schemas/myapp_auth_public/procedures/require_step_up/procedure


SELECT assert_function('myapp_auth_public.require_step_up(text)'::regprocedure, 'boolean'::regtype, false, true, 'STABLE');



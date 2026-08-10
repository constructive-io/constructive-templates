-- Verify: schemas/myapp_auth_public/procedures/current_user_agent/procedure


SELECT assert_function('myapp_auth_public.current_user_agent()'::regprocedure, 'text'::regtype, false, false, 'STABLE');



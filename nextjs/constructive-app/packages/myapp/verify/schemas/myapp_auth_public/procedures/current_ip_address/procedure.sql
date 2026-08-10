-- Verify: schemas/myapp_auth_public/procedures/current_ip_address/procedure


SELECT assert_function('myapp_auth_public.current_ip_address()'::regprocedure, 'inet'::regtype, false, false, 'STABLE');



-- Verify: schemas/myapp_limits_public/procedures/capture_app_limit_defaults/procedure


SELECT assert_function('myapp_limits_public.capture_app_limit_defaults()'::regprocedure, 'jsonb'::regtype, false, false, 'STABLE');



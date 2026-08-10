-- Verify: schemas/myapp_limits_public/procedures/seed_org_limit_defaults/procedure


SELECT assert_function('myapp_limits_public.seed_org_limit_defaults(jsonb)'::regprocedure, 'boolean'::regtype, false, false, 'VOLATILE');



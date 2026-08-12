-- Verify: schemas/myapp_capabilities_public/procedures/app_capabilities_get_mask/procedure


SELECT assert_function('myapp_capabilities_public.app_capabilities_get_mask(uuid[])'::regprocedure, 'bit varying'::regtype, false, false, 'STABLE');



-- Verify: schemas/myapp_capabilities_public/procedures/app_capabilities_get_mask_by_names/procedure


SELECT assert_function('myapp_capabilities_public.app_capabilities_get_mask_by_names(citext[])'::regprocedure, 'bit varying'::regtype, false, false, 'STABLE');



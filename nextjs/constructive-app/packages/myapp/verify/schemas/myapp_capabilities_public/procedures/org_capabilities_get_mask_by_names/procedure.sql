-- Verify: schemas/myapp_capabilities_public/procedures/org_capabilities_get_mask_by_names/procedure


SELECT assert_function('myapp_capabilities_public.org_capabilities_get_mask_by_names(citext[])'::regprocedure, 'bit varying'::regtype, false, false, 'STABLE');



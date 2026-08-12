-- Verify: schemas/myapp_capabilities_public/procedures/org_capabilities_get_by_mask/procedure


SELECT assert_function('myapp_capabilities_public.org_capabilities_get_by_mask(bit varying)'::regprocedure, 'myapp_capabilities_public.org_capabilities'::regtype, true, false, 'STABLE');



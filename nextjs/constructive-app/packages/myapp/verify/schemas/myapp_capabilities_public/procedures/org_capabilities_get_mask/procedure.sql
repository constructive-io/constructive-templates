-- Verify: schemas/myapp_capabilities_public/procedures/org_capabilities_get_mask/procedure


SELECT assert_function('myapp_capabilities_public.org_capabilities_get_mask(uuid[])'::regprocedure, 'bit varying'::regtype, false, false, 'STABLE');



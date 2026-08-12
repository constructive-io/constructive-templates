-- Verify: schemas/myapp_capabilities_public/procedures/app_capabilities_get_padded_mask/procedure


SELECT assert_function('myapp_capabilities_public.app_capabilities_get_padded_mask(bit varying)'::regprocedure, 'bit varying'::regtype, false, false, 'IMMUTABLE');



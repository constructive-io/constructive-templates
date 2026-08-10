-- Verify: schemas/myapp_capabilities_private/trigger_fns/org_capabilities_bitnum_tg


SELECT assert_function('myapp_capabilities_private.org_capabilities_bitnum_tg()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



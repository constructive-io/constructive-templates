-- Verify: schemas/myapp_auth_private/trigger_fns/org_memberships_sprt_principal_sync_tg


SELECT assert_function('myapp_auth_private.org_memberships_sprt_principal_sync_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');



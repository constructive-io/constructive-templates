-- Verify: schemas/myapp_memberships_public/trigger_fns/tg_membership_types_scope_type_sync


SELECT assert_function('myapp_memberships_public.tg_membership_types_scope_type_sync()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');



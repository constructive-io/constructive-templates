-- Verify: schemas/myapp_memberships_public/trigger_fns/tg_membership_types_scope_type_del


SELECT assert_function('myapp_memberships_public.tg_membership_types_scope_type_del()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');



-- Verify: schemas/myapp_invites_private/trigger_fns/org_invites_insert_before_tg


SELECT assert_function('myapp_invites_private.org_invites_insert_before_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');



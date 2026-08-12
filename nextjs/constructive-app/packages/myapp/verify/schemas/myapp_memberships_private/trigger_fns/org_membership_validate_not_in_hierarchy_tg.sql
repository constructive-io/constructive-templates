-- Verify: schemas/myapp_memberships_private/trigger_fns/org_membership_validate_not_in_hierarchy_tg


SELECT assert_function('myapp_memberships_private.org_membership_validate_not_in_hierarchy_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');



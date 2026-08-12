-- Verify: schemas/myapp_memberships_private/procedures/org_rebuild_org_hierarchy_sprt/procedure


SELECT assert_function('myapp_memberships_private.org_rebuild_org_hierarchy_sprt(uuid)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');



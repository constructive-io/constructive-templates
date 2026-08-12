-- Verify: schemas/myapp_memberships_public/procedures/org_is_manager_of/procedure


SELECT assert_function('myapp_memberships_public.org_is_manager_of(uuid, uuid, uuid, int)'::regprocedure, 'boolean'::regtype, false, true, 'STABLE');



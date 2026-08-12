-- Verify: schemas/myapp_memberships_public/procedures/org_get_managers/procedure


SELECT assert_function('myapp_memberships_public.org_get_managers(uuid, uuid, int)'::regprocedure, 'record'::regtype, true, true, 'STABLE');



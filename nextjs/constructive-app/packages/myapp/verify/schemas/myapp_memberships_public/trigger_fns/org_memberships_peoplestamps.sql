-- Verify: schemas/myapp_memberships_public/trigger_fns/org_memberships_peoplestamps


SELECT assert_function('myapp_memberships_public.org_memberships_peoplestamps()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



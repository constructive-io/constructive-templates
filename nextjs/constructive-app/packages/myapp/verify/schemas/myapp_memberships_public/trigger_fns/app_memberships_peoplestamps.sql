-- Verify: schemas/myapp_memberships_public/trigger_fns/app_memberships_peoplestamps


SELECT assert_function('myapp_memberships_public.app_memberships_peoplestamps()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



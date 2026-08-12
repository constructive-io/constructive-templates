-- Verify: schemas/myapp_memberships_public/trigger_fns/app_membership_defaults_peoplestamps


SELECT assert_function('myapp_memberships_public.app_membership_defaults_peoplestamps()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



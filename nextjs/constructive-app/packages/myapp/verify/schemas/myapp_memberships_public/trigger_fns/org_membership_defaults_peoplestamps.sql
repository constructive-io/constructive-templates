-- Verify: schemas/myapp_memberships_public/trigger_fns/org_membership_defaults_peoplestamps


SELECT assert_function('myapp_memberships_public.org_membership_defaults_peoplestamps()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



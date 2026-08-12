-- Verify: schemas/myapp_memberships_public/trigger_fns/org_membership_settings_peoplestamps


SELECT assert_function('myapp_memberships_public.org_membership_settings_peoplestamps()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



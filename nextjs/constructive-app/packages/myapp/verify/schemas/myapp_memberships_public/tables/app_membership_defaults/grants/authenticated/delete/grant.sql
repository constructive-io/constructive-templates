-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_memberships_public.app_membership_defaults'::regclass, 'authenticated', 'DELETE', NULL, true);



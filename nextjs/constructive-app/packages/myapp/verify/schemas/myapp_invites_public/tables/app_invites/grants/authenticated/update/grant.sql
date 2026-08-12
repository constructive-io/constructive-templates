-- Verify: schemas/myapp_invites_public/tables/app_invites/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_invites_public.app_invites'::regclass, 'authenticated', 'UPDATE', NULL, true);



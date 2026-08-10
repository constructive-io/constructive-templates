-- Verify: schemas/myapp_invites_public/tables/app_invites/table


SELECT assert_table('myapp_invites_public.app_invites'::regclass, false, NULL);



-- Verify: schemas/myapp_invites_public/tables/org_invites/table


SELECT assert_table('myapp_invites_public.org_invites'::regclass, false, NULL);



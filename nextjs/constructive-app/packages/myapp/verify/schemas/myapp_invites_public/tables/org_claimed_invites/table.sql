-- Verify: schemas/myapp_invites_public/tables/org_claimed_invites/table


SELECT assert_table('myapp_invites_public.org_claimed_invites'::regclass, false, NULL);



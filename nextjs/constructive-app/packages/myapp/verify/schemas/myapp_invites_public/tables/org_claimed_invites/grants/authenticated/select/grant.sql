-- Verify: schemas/myapp_invites_public/tables/org_claimed_invites/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_invites_public.org_claimed_invites'::regclass, 'authenticated', 'SELECT', NULL, true);



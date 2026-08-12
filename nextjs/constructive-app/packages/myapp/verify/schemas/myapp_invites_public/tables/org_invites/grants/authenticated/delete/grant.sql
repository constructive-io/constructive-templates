-- Verify: schemas/myapp_invites_public/tables/org_invites/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_invites_public.org_invites'::regclass, 'authenticated', 'DELETE', NULL, true);



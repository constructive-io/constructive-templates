-- Verify: schemas/myapp_memberships_public/tables/org_memberships/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_memberships_public.org_memberships'::regclass, 'authenticated', 'UPDATE', ARRAY['is_banned', 'is_approved', 'is_disabled', 'is_read_only'], true);



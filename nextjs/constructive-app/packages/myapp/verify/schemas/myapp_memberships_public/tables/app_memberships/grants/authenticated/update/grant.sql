-- Verify: schemas/myapp_memberships_public/tables/app_memberships/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_memberships_public.app_memberships'::regclass, 'authenticated', 'UPDATE', ARRAY['is_banned', 'is_approved', 'is_verified', 'is_disabled'], true);



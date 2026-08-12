-- Verify: schemas/myapp_memberships_public/tables/app_admin_grants/indexes/app_admin_grants_grantor_id_idx


SELECT assert_index('myapp_memberships_public.app_admin_grants_grantor_id_idx'::regclass, 'myapp_memberships_public.app_admin_grants'::regclass, false);



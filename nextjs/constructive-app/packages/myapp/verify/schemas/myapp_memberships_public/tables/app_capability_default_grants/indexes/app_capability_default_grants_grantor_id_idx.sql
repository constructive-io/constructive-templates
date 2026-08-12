-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_grants/indexes/app_capability_default_grants_grantor_id_idx


SELECT assert_index('myapp_memberships_public.app_capability_default_grants_grantor_id_idx'::regclass, 'myapp_memberships_public.app_capability_default_grants'::regclass, false);



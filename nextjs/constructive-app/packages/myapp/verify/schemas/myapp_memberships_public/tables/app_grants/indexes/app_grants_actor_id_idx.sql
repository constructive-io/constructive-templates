-- Verify: schemas/myapp_memberships_public/tables/app_grants/indexes/app_grants_actor_id_idx


SELECT assert_index('myapp_memberships_public.app_grants_actor_id_idx'::regclass, 'myapp_memberships_public.app_grants'::regclass, false);



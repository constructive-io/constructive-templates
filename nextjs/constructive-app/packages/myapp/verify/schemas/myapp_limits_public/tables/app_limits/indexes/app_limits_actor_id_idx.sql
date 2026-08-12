-- Verify: schemas/myapp_limits_public/tables/app_limits/indexes/app_limits_actor_id_idx


SELECT assert_index('myapp_limits_public.app_limits_actor_id_idx'::regclass, 'myapp_limits_public.app_limits'::regclass, false);



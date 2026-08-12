-- Verify: schemas/myapp_limits_public/tables/org_limits/indexes/org_limits_actor_id_idx


SELECT assert_index('myapp_limits_public.org_limits_actor_id_idx'::regclass, 'myapp_limits_public.org_limits'::regclass, false);



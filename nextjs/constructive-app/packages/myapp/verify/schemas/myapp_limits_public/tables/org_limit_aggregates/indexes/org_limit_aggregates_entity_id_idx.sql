-- Verify: schemas/myapp_limits_public/tables/org_limit_aggregates/indexes/org_limit_aggregates_entity_id_idx


SELECT assert_index('myapp_limits_public.org_limit_aggregates_entity_id_idx'::regclass, 'myapp_limits_public.org_limit_aggregates'::regclass, false);



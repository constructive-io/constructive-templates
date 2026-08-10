-- Verify: schemas/routing_public/tables/site_web_configs/indexes/site_web_configs_created_at_idx


SELECT assert_index(CAST('routing_public.site_web_configs_created_at_idx' AS regclass), CAST('routing_public.site_web_configs' AS regclass), false);
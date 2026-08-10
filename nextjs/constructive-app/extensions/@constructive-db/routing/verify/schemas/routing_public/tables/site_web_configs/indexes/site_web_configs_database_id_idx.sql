-- Verify: schemas/routing_public/tables/site_web_configs/indexes/site_web_configs_database_id_idx


SELECT assert_index(CAST('routing_public.site_web_configs_database_id_idx' AS regclass), CAST('routing_public.site_web_configs' AS regclass), false);
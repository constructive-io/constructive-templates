-- Verify: schemas/routing_public/tables/site_web_configs/table


SELECT assert_table(CAST('routing_public.site_web_configs' AS regclass), false, NULL);
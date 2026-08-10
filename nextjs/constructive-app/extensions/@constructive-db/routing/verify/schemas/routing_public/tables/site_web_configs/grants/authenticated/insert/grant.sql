-- Verify: schemas/routing_public/tables/site_web_configs/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.site_web_configs' AS regclass), 'authenticated', 'INSERT', NULL, true);
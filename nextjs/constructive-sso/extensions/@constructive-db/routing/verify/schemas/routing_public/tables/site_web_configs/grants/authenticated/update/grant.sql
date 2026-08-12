-- Verify: schemas/routing_public/tables/site_web_configs/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.site_web_configs' AS regclass), 'authenticated', 'UPDATE', NULL, true);
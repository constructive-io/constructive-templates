-- Verify: schemas/routing_public/tables/site_web_configs/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.site_web_configs' AS regclass), 'authenticated', 'DELETE', NULL, true);
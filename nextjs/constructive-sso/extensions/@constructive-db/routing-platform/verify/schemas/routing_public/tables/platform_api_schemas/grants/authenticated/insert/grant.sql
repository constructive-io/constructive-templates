-- Verify: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_api_schemas' AS regclass), 'authenticated', 'INSERT', NULL, true);
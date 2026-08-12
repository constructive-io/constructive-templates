-- Verify: schemas/routing_public/tables/platform_pages/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_pages' AS regclass), 'authenticated', 'INSERT', NULL, true);
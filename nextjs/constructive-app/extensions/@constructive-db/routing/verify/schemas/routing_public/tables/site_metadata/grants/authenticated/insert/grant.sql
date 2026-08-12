-- Verify: schemas/routing_public/tables/site_metadata/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.site_metadata' AS regclass), 'authenticated', 'INSERT', NULL, true);
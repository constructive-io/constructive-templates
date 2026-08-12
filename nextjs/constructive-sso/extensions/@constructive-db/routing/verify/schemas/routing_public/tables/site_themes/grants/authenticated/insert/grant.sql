-- Verify: schemas/routing_public/tables/site_themes/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.site_themes' AS regclass), 'authenticated', 'INSERT', NULL, true);
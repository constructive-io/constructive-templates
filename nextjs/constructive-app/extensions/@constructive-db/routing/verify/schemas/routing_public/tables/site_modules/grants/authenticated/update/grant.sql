-- Verify: schemas/routing_public/tables/site_modules/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.site_modules' AS regclass), 'authenticated', 'UPDATE', NULL, true);
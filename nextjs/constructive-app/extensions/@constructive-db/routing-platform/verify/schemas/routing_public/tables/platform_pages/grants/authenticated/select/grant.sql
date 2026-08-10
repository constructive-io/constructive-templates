-- Verify: schemas/routing_public/tables/platform_pages/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_pages' AS regclass), 'authenticated', 'SELECT', NULL, true);
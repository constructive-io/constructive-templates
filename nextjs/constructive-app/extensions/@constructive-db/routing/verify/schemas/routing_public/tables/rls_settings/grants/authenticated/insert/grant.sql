-- Verify: schemas/routing_public/tables/rls_settings/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.rls_settings' AS regclass), 'authenticated', 'INSERT', NULL, true);
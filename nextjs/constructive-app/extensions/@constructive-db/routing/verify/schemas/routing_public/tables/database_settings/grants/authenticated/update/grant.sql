-- Verify: schemas/routing_public/tables/database_settings/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.database_settings' AS regclass), 'authenticated', 'UPDATE', NULL, true);
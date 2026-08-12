-- Verify: schemas/routing_public/tables/database_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.database_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);
-- Verify: schemas/routing_public/tables/cors_settings/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.cors_settings' AS regclass), 'authenticated', 'UPDATE', NULL, true);
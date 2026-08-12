-- Verify: schemas/routing_public/tables/cors_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.cors_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);
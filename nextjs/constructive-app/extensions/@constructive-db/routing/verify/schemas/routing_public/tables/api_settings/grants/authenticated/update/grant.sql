-- Verify: schemas/routing_public/tables/api_settings/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.api_settings' AS regclass), 'authenticated', 'UPDATE', NULL, true);
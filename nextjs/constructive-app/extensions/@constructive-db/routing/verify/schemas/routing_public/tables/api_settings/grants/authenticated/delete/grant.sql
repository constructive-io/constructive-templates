-- Verify: schemas/routing_public/tables/api_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.api_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);
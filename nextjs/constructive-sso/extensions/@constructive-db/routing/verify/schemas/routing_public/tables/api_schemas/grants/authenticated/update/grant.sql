-- Verify: schemas/routing_public/tables/api_schemas/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.api_schemas' AS regclass), 'authenticated', 'UPDATE', NULL, true);
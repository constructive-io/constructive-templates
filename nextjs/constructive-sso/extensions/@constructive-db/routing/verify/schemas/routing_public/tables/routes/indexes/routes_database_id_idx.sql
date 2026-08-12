-- Verify: schemas/routing_public/tables/routes/indexes/routes_database_id_idx


SELECT assert_index(CAST('routing_public.routes_database_id_idx' AS regclass), CAST('routing_public.routes' AS regclass), false);
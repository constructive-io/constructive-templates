-- Verify: schemas/routing_public/tables/pages/indexes/pages_database_id_idx


SELECT assert_index(CAST('routing_public.pages_database_id_idx' AS regclass), CAST('routing_public.pages' AS regclass), false);
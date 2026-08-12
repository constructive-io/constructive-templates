-- Verify: schemas/routing_public/tables/routes/indexes/routes_updated_at_idx


SELECT assert_index(CAST('routing_public.routes_updated_at_idx' AS regclass), CAST('routing_public.routes' AS regclass), false);
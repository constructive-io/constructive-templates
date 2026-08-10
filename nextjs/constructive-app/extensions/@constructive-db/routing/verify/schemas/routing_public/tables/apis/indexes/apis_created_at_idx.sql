-- Verify: schemas/routing_public/tables/apis/indexes/apis_created_at_idx


SELECT assert_index(CAST('routing_public.apis_created_at_idx' AS regclass), CAST('routing_public.apis' AS regclass), false);
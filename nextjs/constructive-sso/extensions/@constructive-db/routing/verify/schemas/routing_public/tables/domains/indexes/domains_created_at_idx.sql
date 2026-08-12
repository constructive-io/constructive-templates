-- Verify: schemas/routing_public/tables/domains/indexes/domains_created_at_idx


SELECT assert_index(CAST('routing_public.domains_created_at_idx' AS regclass), CAST('routing_public.domains' AS regclass), false);
-- Verify: schemas/routing_public/tables/managed_domains/indexes/managed_domains_created_at_idx


SELECT assert_index(CAST('routing_public.managed_domains_created_at_idx' AS regclass), CAST('routing_public.managed_domains' AS regclass), false);
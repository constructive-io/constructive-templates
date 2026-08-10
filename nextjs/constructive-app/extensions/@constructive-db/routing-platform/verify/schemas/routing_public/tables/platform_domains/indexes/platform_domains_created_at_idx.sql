-- Verify: schemas/routing_public/tables/platform_domains/indexes/platform_domains_created_at_idx


SELECT assert_index(CAST('routing_public.platform_domains_created_at_idx' AS regclass), CAST('routing_public.platform_domains' AS regclass), false);
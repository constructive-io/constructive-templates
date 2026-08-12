-- Verify: schemas/routing_public/tables/platform_managed_domains/indexes/platform_managed_domains_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_managed_domains_updated_at_idx' AS regclass), CAST('routing_public.platform_managed_domains' AS regclass), false);
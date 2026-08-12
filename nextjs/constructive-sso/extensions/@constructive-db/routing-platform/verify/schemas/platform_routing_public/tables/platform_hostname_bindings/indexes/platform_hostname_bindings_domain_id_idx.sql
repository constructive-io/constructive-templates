-- Verify: schemas/platform_routing_public/tables/platform_hostname_bindings/indexes/platform_hostname_bindings_domain_id_idx


SELECT assert_index(CAST('platform_routing_public.platform_hostname_bindings_domain_id_idx' AS regclass), CAST('platform_routing_public.platform_hostname_bindings' AS regclass), false);
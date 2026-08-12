-- Verify: schemas/routing_public/tables/hostname_bindings/indexes/hostname_bindings_domain_id_idx


SELECT assert_index(CAST('routing_public.hostname_bindings_domain_id_idx' AS regclass), CAST('routing_public.hostname_bindings' AS regclass), false);
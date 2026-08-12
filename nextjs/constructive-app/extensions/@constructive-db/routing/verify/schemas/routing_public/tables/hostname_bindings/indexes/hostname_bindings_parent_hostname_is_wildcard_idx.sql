-- Verify: schemas/routing_public/tables/hostname_bindings/indexes/hostname_bindings_parent_hostname_is_wildcard_idx


SELECT assert_index(CAST('routing_public.hostname_bindings_parent_hostname_is_wildcard_idx' AS regclass), CAST('routing_public.hostname_bindings' AS regclass), false);
-- Verify: schemas/routing_public/tables/route_bindings/indexes/route_bindings_domain_id_is_active_idx


SELECT assert_index(CAST('routing_public.route_bindings_domain_id_is_active_idx' AS regclass), CAST('routing_public.route_bindings' AS regclass), false);
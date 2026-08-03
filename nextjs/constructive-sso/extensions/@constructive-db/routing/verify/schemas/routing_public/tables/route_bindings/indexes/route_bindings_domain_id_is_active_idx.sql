-- Verify: schemas/routing_public/tables/route_bindings/indexes/route_bindings_domain_id_is_active_idx


SELECT verify_index('routing_public.route_bindings', 'route_bindings_domain_id_is_active_idx');
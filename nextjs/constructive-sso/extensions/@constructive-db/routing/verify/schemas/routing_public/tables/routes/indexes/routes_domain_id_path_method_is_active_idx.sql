-- Verify: schemas/routing_public/tables/routes/indexes/routes_domain_id_path_method_is_active_idx


SELECT verify_index('routing_public.routes', 'routes_domain_id_path_method_is_active_idx');
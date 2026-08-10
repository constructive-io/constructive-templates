-- Verify: schemas/routing_public/tables/routes/indexes/routes_domain_id_path_method_is_active_idx


SELECT assert_index(CAST('routing_public.routes_domain_id_path_method_is_active_idx' AS regclass), CAST('routing_public.routes' AS regclass), false);
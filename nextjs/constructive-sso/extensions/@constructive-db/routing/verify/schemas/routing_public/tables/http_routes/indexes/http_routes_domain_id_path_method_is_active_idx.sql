-- Verify: schemas/routing_public/tables/http_routes/indexes/http_routes_domain_id_path_method_is_active_idx


SELECT assert_index(CAST('routing_public.http_routes_domain_id_path_method_is_active_idx' AS regclass), CAST('routing_public.http_routes' AS regclass), false);
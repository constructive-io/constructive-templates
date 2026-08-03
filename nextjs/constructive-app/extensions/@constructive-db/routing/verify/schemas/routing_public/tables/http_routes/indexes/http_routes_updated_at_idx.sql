-- Verify: schemas/routing_public/tables/http_routes/indexes/http_routes_updated_at_idx


SELECT verify_index('routing_public.http_routes', 'http_routes_updated_at_idx');
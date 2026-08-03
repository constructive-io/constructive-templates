-- Verify: schemas/routing_public/tables/routes/indexes/routes_updated_at_idx


SELECT verify_index('routing_public.routes', 'routes_updated_at_idx');
-- Verify: schemas/routing_public/tables/routes/indexes/routes_created_at_idx


SELECT verify_index('routing_public.routes', 'routes_created_at_idx');
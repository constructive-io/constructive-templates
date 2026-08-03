-- Verify: schemas/routing_public/tables/apis/indexes/apis_created_at_idx


SELECT verify_index('routing_public.apis', 'apis_created_at_idx');
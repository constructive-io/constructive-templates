-- Verify: schemas/routing_public/tables/apis/indexes/apis_updated_at_idx


SELECT verify_index('routing_public.apis', 'apis_updated_at_idx');
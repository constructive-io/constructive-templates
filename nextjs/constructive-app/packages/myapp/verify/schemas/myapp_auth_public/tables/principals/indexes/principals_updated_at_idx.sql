-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_updated_at_idx


SELECT verify_index('myapp_auth_public.principals', 'principals_updated_at_idx');



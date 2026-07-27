-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_created_at_idx


SELECT verify_index('myapp_auth_public.principals', 'principals_created_at_idx');



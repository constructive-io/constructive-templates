-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_owner_id_idx


SELECT verify_index('myapp_auth_public.principals', 'principals_owner_id_idx');



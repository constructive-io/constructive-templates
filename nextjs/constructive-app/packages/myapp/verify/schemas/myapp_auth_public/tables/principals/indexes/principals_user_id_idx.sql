-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_user_id_idx


SELECT verify_index('myapp_auth_public.principals', 'principals_user_id_idx');



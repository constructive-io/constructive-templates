-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_user_id_idx


SELECT assert_index('myapp_auth_public.principals_user_id_idx'::regclass, 'myapp_auth_public.principals'::regclass, false);



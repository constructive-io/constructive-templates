-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_owner_id_idx


SELECT assert_index('myapp_auth_public.principals_owner_id_idx'::regclass, 'myapp_auth_public.principals'::regclass, false);



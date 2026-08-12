-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_created_at_idx


SELECT assert_index('myapp_auth_public.principals_created_at_idx'::regclass, 'myapp_auth_public.principals'::regclass, false);



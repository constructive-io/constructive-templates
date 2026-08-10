-- Verify: schemas/myapp_auth_public/tables/principals/indexes/principals_updated_at_idx


SELECT assert_index('myapp_auth_public.principals_updated_at_idx'::regclass, 'myapp_auth_public.principals'::regclass, false);



-- Verify: schemas/myapp_users_public/tables/users/indexes/users_search_tsv_gin_idx


SELECT assert_index('myapp_users_public.users_search_tsv_gin_idx'::regclass, 'myapp_users_public.users'::regclass, false);



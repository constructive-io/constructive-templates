-- Verify: schemas/myapp_users_public/tables/users/triggers/users_search_tsv_tsv_update_tg


SELECT assert_trigger('myapp_users_public.users'::regclass, 'users_search_tsv_tsv_update_tg', 'myapp_app_private.users_search_tsv_tsv'::regproc, 19);



-- Verify: schemas/myapp_app_private/trigger_fns/users_search_tsv_tsv


SELECT assert_function('myapp_app_private.users_search_tsv_tsv()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');



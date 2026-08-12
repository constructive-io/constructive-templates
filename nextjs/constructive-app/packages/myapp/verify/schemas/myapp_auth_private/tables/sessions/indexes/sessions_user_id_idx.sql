-- Verify: schemas/myapp_auth_private/tables/sessions/indexes/sessions_user_id_idx


SELECT assert_index('myapp_auth_private.sessions_user_id_idx'::regclass, 'myapp_auth_private.sessions'::regclass, false);



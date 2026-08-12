-- Verify: schemas/myapp_auth_private/tables/sessions/indexes/sessions_updated_at_idx


SELECT assert_index('myapp_auth_private.sessions_updated_at_idx'::regclass, 'myapp_auth_private.sessions'::regclass, false);



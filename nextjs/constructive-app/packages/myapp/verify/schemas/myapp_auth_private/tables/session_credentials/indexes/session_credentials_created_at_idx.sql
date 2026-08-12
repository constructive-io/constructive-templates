-- Verify: schemas/myapp_auth_private/tables/session_credentials/indexes/session_credentials_created_at_idx


SELECT assert_index('myapp_auth_private.session_credentials_created_at_idx'::regclass, 'myapp_auth_private.session_credentials'::regclass, false);



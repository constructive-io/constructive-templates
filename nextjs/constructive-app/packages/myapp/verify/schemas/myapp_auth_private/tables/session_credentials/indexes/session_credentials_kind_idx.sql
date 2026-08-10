-- Verify: schemas/myapp_auth_private/tables/session_credentials/indexes/session_credentials_kind_idx


SELECT assert_index('myapp_auth_private.session_credentials_kind_idx'::regclass, 'myapp_auth_private.session_credentials'::regclass, false);



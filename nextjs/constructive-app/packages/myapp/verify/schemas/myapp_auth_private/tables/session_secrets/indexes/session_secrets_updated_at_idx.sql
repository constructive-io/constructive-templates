-- Verify: schemas/myapp_auth_private/tables/session_secrets/indexes/session_secrets_updated_at_idx


SELECT assert_index('myapp_auth_private.session_secrets_updated_at_idx'::regclass, 'myapp_auth_private.session_secrets'::regclass, false);



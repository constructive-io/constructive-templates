-- Verify: schemas/myapp_store_private/tables/user_secrets/indexes/user_secrets_updated_at_idx


SELECT assert_index('myapp_store_private.user_secrets_updated_at_idx'::regclass, 'myapp_store_private.user_secrets'::regclass, false);



-- Verify: schemas/myapp_auth_private/tables/identity_providers/triggers/identity_providers_quota_trg


SELECT assert_trigger('myapp_auth_private.identity_providers'::regclass, 'identity_providers_quota_trg', 'utils.enforce_identity_providers_quota'::regproc, 7);



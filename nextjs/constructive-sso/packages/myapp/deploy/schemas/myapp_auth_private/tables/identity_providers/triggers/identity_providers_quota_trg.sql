-- Deploy: schemas/myapp_auth_private/tables/identity_providers/triggers/identity_providers_quota_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


CREATE TRIGGER identity_providers_quota_trg
BEFORE INSERT ON myapp_auth_private.identity_providers
FOR EACH ROW
EXECUTE PROCEDURE utils.enforce_identity_providers_quota ( 'myapp_auth_private', 'app_settings_auth' );


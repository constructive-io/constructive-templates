-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/enabled/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/enabled/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.enabled IS E'@has_guard
Whether sign-in via this provider is currently allowed. Toggled by enable_identity_provider / disable_identity_provider admin procedures. Disabled providers remain in the public-safe view as enabled=false so client UIs can grey out the button.';


-- Deploy: schemas/myapp_auth_private/tables/identity_providers/columns/extra_authorization_params/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/extra_authorization_params/column


COMMENT ON COLUMN myapp_auth_private.identity_providers.extra_authorization_params IS E'@has_guard
Extra query parameters merged into the authorization URL (e.g. {"prompt":"select_account"}). Admin procedure rejects reserved OAuth/OIDC keys: client_id, redirect_uri, state, nonce, code_challenge, code_challenge_method, response_type, scope.';


-- Deploy: schemas/myapp_auth_private/views/webauthn_credentials/view
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


CREATE VIEW myapp_auth_private.webauthn_credentials WITH ( security_invoker = true ) AS SELECT
  id,
  owner_id,
  webauthn_user_id,
  credential_id,
  transports,
  public_key,
  sign_count,
  backup_state
FROM myapp_user_identifiers_public.webauthn_credentials;


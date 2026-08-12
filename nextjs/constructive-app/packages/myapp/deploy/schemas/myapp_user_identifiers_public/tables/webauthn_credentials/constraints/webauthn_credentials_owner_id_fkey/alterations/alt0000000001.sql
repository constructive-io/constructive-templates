-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_owner_id_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_owner_id_fkey/constraint


COMMENT ON CONSTRAINT webauthn_credentials_owner_id_fkey ON myapp_user_identifiers_public.webauthn_credentials IS E'@foreignFieldName webauthnCredentials';


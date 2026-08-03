-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/sign_count/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/sign_count/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.sign_count IS E'Monotonic signature counter. Strict-increase check during sign-in detects cloned credentials. 0 means the authenticator does not implement a counter.';


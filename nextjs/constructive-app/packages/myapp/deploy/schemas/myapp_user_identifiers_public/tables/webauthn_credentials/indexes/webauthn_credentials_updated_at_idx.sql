-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/indexes/webauthn_credentials_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/updated_at/column


CREATE INDEX webauthn_credentials_updated_at_idx ON myapp_user_identifiers_public.webauthn_credentials ( updated_at );


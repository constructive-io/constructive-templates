-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/indexes/webauthn_credentials_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/created_at/column


CREATE INDEX webauthn_credentials_created_at_idx ON myapp_user_identifiers_public.webauthn_credentials ( created_at );


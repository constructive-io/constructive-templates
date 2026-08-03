-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/update/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


GRANT UPDATE (name) ON myapp_user_identifiers_public.webauthn_credentials TO authenticated;


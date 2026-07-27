-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


GRANT SELECT ON myapp_user_identifiers_public.webauthn_credentials TO authenticated;


-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_user_identifiers_public.webauthn_credentials
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );


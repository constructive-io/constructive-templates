-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_user_identifiers_private.connected_accounts
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );


-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/identifier/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/identifier/column


COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.identifier IS 'A unique identifier for the user within the service';


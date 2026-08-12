-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/details/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/details/column


COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.details IS 'Additional profile details extracted from this login method';


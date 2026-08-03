-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/is_verified/column


COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.is_verified IS 'Whether this connected account has been verified';


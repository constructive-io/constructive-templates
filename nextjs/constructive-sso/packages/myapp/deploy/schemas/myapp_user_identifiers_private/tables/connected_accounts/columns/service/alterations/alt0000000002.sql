-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/service/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/service/column


COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.service IS E'The service used, e.g. `twitter` or `github`.';


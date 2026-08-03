-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/indexes/connected_accounts_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/columns/created_at/column


CREATE INDEX connected_accounts_created_at_idx ON myapp_user_identifiers_private.connected_accounts ( created_at );


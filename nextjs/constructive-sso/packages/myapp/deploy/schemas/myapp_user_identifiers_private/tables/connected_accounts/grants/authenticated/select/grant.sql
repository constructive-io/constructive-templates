-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


GRANT SELECT ON myapp_user_identifiers_private.connected_accounts TO authenticated;


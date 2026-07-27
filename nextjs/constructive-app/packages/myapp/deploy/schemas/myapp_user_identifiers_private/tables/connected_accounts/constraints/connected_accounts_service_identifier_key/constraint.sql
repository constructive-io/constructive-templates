-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/constraints/connected_accounts_service_identifier_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD CONSTRAINT connected_accounts_service_identifier_key 
    UNIQUE (service, identifier);


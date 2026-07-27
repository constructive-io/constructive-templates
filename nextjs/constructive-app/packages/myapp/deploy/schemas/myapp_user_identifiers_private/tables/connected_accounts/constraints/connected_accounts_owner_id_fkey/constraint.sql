-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/constraints/connected_accounts_owner_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD CONSTRAINT connected_accounts_owner_id_fkey 
    FOREIGN KEY(owner_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;


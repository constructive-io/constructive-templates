-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/constraints/webauthn_credentials_owner_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_owner_id_fkey 
    FOREIGN KEY(owner_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;


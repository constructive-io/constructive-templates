-- Deploy: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_owner_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_owner_id_fkey 
    FOREIGN KEY(owner_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;


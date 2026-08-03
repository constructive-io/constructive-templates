-- Deploy: schemas/myapp_auth_public/tables/principals/constraints/principals_user_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_public/tables/principals/table


ALTER TABLE myapp_auth_public.principals 
  ADD CONSTRAINT principals_user_id_fkey 
    FOREIGN KEY(user_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;


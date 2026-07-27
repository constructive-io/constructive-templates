-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/constraints/auth_user_devices_user_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD CONSTRAINT auth_user_devices_user_id_fkey 
    FOREIGN KEY(user_id) 
    REFERENCES myapp_users_public.users (id) 
    ON DELETE CASCADE;


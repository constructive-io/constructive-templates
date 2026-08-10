-- Deploy: schemas/myapp_users_public/tables/user_settings_security/constraints/user_settings_securities_owner_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


ALTER TABLE myapp_users_public.user_settings_security 
  ADD CONSTRAINT user_settings_securities_owner_id_key 
    UNIQUE (owner_id);


-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/owner_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


ALTER TABLE myapp_users_public.user_settings_security 
  ADD COLUMN owner_id uuid;


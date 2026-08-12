-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/owner_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/owner_id/column


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN owner_id SET DEFAULT jwt_public.current_user_id();


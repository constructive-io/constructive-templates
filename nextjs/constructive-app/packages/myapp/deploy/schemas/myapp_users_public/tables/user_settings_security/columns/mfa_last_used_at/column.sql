-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/mfa_last_used_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


ALTER TABLE myapp_users_public.user_settings_security 
  ADD COLUMN mfa_last_used_at timestamptz;


-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/email_mfa_enabled/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


ALTER TABLE myapp_users_public.user_settings_security 
  ADD COLUMN email_mfa_enabled bool;


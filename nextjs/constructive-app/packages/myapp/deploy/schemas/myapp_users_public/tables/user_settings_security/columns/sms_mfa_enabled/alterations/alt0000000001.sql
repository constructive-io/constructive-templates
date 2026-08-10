-- Deploy: schemas/myapp_users_public/tables/user_settings_security/columns/sms_mfa_enabled/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table
-- requires: schemas/myapp_users_public/tables/user_settings_security/columns/sms_mfa_enabled/column


ALTER TABLE myapp_users_public.user_settings_security 
  ALTER COLUMN sms_mfa_enabled SET NOT NULL;


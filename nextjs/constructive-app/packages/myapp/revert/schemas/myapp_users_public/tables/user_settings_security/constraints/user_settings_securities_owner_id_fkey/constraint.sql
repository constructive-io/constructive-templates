-- Revert: schemas/myapp_users_public/tables/user_settings_security/constraints/user_settings_securities_owner_id_fkey/constraint


ALTER TABLE myapp_users_public.user_settings_security 
  DROP CONSTRAINT user_settings_securities_owner_id_fkey;



-- Revert: schemas/myapp_users_public/tables/users/columns/display_name/alterations/alt0000000001


ALTER TABLE myapp_users_public.users 
  DROP CONSTRAINT users_display_name_chk;



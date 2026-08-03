-- Revert: schemas/myapp_users_public/tables/users/columns/username/alterations/alt0000000001


ALTER TABLE myapp_users_public.users 
  DROP CONSTRAINT users_username_chk;



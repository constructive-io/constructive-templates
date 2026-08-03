-- Revert: schemas/myapp_auth_public/tables/principals/columns/user_id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN user_id DROP NOT NULL;



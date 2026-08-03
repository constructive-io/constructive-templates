-- Revert: schemas/myapp_auth_public/tables/principals/columns/user_id/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN user_id RESTRICT;



-- Revert: schemas/myapp_auth_public/tables/principals/columns/created_at/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN created_at RESTRICT;



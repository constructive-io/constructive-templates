-- Revert: schemas/myapp_auth_public/tables/principals/columns/updated_at/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN updated_at RESTRICT;



-- Revert: schemas/myapp_auth_public/tables/principals/columns/is_read_only/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN is_read_only DROP NOT NULL;



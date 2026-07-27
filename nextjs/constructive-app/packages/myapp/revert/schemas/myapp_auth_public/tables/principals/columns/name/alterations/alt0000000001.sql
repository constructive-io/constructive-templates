-- Revert: schemas/myapp_auth_public/tables/principals/columns/name/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN name DROP NOT NULL;



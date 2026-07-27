-- Revert: schemas/myapp_auth_public/tables/principals/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN created_at DROP DEFAULT;



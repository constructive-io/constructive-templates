-- Revert: schemas/myapp_auth_public/tables/principals/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN updated_at DROP DEFAULT;



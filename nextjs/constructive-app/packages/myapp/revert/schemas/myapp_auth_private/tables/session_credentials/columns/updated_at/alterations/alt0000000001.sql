-- Revert: schemas/myapp_auth_private/tables/session_credentials/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN updated_at DROP DEFAULT;



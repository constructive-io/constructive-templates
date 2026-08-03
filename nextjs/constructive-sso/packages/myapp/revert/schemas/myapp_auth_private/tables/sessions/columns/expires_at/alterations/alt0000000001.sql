-- Revert: schemas/myapp_auth_private/tables/sessions/columns/expires_at/alterations/alt0000000001


ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN expires_at DROP NOT NULL;



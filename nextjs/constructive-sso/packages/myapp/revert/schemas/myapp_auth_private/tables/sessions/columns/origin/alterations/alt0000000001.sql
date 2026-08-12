-- Revert: schemas/myapp_auth_private/tables/sessions/columns/origin/alterations/alt0000000001


ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN origin DROP DEFAULT;



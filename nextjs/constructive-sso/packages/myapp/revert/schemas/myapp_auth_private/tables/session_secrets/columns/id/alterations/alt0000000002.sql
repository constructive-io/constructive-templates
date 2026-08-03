-- Revert: schemas/myapp_auth_private/tables/session_secrets/columns/id/alterations/alt0000000002


ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN id DROP DEFAULT;



-- Revert: schemas/myapp_auth_private/tables/session_credentials/columns/principal_id/column


ALTER TABLE myapp_auth_private.session_credentials 
  DROP COLUMN principal_id RESTRICT;



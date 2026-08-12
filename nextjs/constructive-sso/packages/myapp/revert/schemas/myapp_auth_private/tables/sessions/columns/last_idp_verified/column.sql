-- Revert: schemas/myapp_auth_private/tables/sessions/columns/last_idp_verified/column


ALTER TABLE myapp_auth_private.sessions 
  DROP COLUMN last_idp_verified RESTRICT;



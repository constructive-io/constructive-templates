-- Revert: schemas/myapp_auth_private/tables/identity_providers/columns/userinfo_url/column


ALTER TABLE myapp_auth_private.identity_providers 
  DROP COLUMN userinfo_url RESTRICT;



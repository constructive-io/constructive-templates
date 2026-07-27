-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/use_admin_owner/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN use_admin_owner DROP NOT NULL;



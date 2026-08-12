-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN id DROP NOT NULL;



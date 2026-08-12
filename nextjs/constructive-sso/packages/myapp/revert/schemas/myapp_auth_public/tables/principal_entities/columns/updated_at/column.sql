-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/updated_at/column


ALTER TABLE myapp_auth_public.principal_entities 
  DROP COLUMN updated_at RESTRICT;



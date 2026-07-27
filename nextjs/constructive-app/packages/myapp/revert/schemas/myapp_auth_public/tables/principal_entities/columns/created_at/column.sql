-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/created_at/column


ALTER TABLE myapp_auth_public.principal_entities 
  DROP COLUMN created_at RESTRICT;



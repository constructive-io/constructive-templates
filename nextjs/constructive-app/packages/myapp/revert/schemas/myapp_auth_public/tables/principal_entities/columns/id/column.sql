-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/id/column


ALTER TABLE myapp_auth_public.principal_entities 
  DROP COLUMN id RESTRICT;



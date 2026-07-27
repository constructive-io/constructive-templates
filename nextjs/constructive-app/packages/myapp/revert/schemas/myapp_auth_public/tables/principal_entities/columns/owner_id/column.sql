-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/owner_id/column


ALTER TABLE myapp_auth_public.principal_entities 
  DROP COLUMN owner_id RESTRICT;



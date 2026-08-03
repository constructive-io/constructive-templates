-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/entity_id/column


ALTER TABLE myapp_auth_public.principal_entities 
  DROP COLUMN entity_id RESTRICT;



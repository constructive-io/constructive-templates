-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/entity_id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN entity_id DROP NOT NULL;



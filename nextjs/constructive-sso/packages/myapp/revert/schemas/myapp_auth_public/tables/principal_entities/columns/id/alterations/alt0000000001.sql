-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN id DROP NOT NULL;



-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/owner_id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN owner_id DROP NOT NULL;



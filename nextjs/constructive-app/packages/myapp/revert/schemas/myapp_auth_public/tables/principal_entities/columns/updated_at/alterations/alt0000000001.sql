-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN updated_at DROP DEFAULT;



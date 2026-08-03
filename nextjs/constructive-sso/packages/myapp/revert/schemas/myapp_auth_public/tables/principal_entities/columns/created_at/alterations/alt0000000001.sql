-- Revert: schemas/myapp_auth_public/tables/principal_entities/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN created_at DROP DEFAULT;



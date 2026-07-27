-- Revert: schemas/myapp_auth_public/tables/principals/columns/id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN id DROP NOT NULL;



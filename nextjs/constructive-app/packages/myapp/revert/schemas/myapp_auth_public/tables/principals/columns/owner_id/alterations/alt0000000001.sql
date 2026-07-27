-- Revert: schemas/myapp_auth_public/tables/principals/columns/owner_id/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN owner_id DROP NOT NULL;



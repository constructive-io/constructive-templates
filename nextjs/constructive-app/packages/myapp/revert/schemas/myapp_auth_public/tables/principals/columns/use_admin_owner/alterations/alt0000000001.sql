-- Revert: schemas/myapp_auth_public/tables/principals/columns/use_admin_owner/alterations/alt0000000001


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN use_admin_owner DROP NOT NULL;



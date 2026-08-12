-- Revert: schemas/myapp_memberships_public/tables/app_memberships/columns/granted/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN granted DROP NOT NULL;



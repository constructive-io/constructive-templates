-- Revert: schemas/myapp_memberships_public/tables/app_memberships/columns/capabilities/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN capabilities DROP NOT NULL;



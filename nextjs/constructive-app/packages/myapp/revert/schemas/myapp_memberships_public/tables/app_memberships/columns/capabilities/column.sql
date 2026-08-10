-- Revert: schemas/myapp_memberships_public/tables/app_memberships/columns/capabilities/column


ALTER TABLE myapp_memberships_public.app_memberships 
  DROP COLUMN capabilities RESTRICT;



-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/id/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_capability_default_grants 
  ALTER COLUMN id DROP NOT NULL;



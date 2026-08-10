-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/capability_id/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_capability_default_grants 
  ALTER COLUMN capability_id DROP NOT NULL;



-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  ALTER COLUMN created_at DROP DEFAULT;



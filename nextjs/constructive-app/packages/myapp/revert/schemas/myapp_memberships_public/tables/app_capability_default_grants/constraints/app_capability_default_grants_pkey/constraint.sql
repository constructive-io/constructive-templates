-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/constraints/app_capability_default_grants_pkey/constraint


ALTER TABLE myapp_memberships_public.app_capability_default_grants 
  DROP CONSTRAINT app_capability_default_grants_pkey;



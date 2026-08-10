-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/constraints/app_capabilities_pkey/constraint


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DROP CONSTRAINT app_capabilities_pkey;



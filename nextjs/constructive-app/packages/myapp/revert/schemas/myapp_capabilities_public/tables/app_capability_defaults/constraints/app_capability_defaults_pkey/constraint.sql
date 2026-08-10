-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/constraints/app_capability_defaults_pkey/constraint


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  DROP CONSTRAINT app_capability_defaults_pkey;



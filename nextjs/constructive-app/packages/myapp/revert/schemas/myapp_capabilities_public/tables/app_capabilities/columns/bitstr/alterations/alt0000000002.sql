-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/bitstr/alterations/alt0000000002


ALTER TABLE myapp_capabilities_public.app_capabilities 
  ALTER COLUMN bitstr DROP DEFAULT;



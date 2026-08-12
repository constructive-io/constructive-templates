-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/bitnum/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DROP CONSTRAINT app_capabilities_bitnum_chk;



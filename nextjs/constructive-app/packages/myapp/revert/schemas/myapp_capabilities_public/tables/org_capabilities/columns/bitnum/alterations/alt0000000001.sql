-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitnum/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.org_capabilities 
  DROP CONSTRAINT org_capabilities_bitnum_chk;



-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/kind/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.app_capabilities 
  ALTER COLUMN kind DROP NOT NULL;



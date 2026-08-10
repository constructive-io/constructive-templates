-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/columns/id/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.app_capabilities 
  ALTER COLUMN id DROP NOT NULL;



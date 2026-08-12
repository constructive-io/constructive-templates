-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/columns/id/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ALTER COLUMN id DROP NOT NULL;



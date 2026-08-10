-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/columns/kind/alterations/alt0000000001


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ALTER COLUMN kind DROP NOT NULL;



-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/columns/id/column


ALTER TABLE myapp_capabilities_public.app_capabilities 
  ALTER COLUMN id SET NOT NULL;


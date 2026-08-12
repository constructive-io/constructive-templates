-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/columns/kind/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table


ALTER TABLE myapp_capabilities_public.app_capabilities 
  ADD COLUMN kind text;


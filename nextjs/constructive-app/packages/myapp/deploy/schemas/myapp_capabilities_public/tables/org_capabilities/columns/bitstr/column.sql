-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitstr/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ADD COLUMN bitstr bit(64);


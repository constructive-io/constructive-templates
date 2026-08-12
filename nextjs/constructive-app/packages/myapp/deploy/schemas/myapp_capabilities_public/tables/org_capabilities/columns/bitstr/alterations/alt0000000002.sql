-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitstr/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitstr/column


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ALTER COLUMN bitstr SET DEFAULT (lpad('', 64, '0'))::bit(64);


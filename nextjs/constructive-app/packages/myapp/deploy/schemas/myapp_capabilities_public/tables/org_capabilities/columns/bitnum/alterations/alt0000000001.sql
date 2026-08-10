-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitnum/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/columns/bitnum/column


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ADD CONSTRAINT org_capabilities_bitnum_chk 
    CHECK (bitnum >= 1 AND bitnum <= 64);


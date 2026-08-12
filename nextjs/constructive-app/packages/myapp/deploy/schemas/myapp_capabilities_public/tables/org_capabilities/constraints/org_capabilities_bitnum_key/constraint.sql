-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/constraints/org_capabilities_bitnum_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


ALTER TABLE myapp_capabilities_public.org_capabilities 
  ADD CONSTRAINT org_capabilities_bitnum_key 
    UNIQUE (bitnum);


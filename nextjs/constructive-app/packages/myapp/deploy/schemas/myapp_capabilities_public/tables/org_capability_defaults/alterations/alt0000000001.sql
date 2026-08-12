-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/table


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  DISABLE ROW LEVEL SECURITY;


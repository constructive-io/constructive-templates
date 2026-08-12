-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  DISABLE ROW LEVEL SECURITY;


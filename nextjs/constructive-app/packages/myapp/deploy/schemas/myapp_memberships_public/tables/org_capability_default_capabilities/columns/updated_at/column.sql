-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  ADD COLUMN updated_at timestamptz;


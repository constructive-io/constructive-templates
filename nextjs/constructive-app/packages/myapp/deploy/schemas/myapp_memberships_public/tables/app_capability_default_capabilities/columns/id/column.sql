-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  ADD COLUMN id uuid;


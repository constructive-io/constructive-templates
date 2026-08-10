-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/created_at/column


ALTER TABLE myapp_memberships_public.app_capability_default_capabilities 
  ALTER COLUMN created_at SET DEFAULT now();


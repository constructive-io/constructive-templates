-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/capability_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_grants/table
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/capability_id/column


ALTER TABLE myapp_memberships_public.app_capability_default_grants 
  ALTER COLUMN capability_id SET NOT NULL;


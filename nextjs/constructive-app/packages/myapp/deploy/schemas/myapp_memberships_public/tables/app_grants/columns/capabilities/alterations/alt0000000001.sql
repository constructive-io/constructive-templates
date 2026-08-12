-- Deploy: schemas/myapp_memberships_public/tables/app_grants/columns/capabilities/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_grants/table
-- requires: schemas/myapp_memberships_public/tables/app_grants/columns/capabilities/column


ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN capabilities SET NOT NULL;


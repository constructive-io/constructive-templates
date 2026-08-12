-- Deploy: schemas/myapp_memberships_public/tables/app_grants/columns/capabilities/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_grants/table


ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN capabilities bit(64);


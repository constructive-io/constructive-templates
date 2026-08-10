-- Deploy: schemas/myapp_memberships_public/tables/app_memberships/columns/capabilities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_memberships/table
-- requires: schemas/myapp_memberships_public/tables/app_memberships/columns/capabilities/column


ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN capabilities SET DEFAULT (lpad('', 64, '0'))::bit(64);


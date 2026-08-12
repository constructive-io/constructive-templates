-- Deploy: schemas/myapp_memberships_public/tables/org_grants/columns/capabilities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_grants/table
-- requires: schemas/myapp_memberships_public/tables/org_grants/columns/capabilities/column


ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN capabilities SET DEFAULT (lpad('', 64, '0'))::bit(64);


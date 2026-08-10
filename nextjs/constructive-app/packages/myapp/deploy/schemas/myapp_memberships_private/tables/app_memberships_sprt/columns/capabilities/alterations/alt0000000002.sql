-- Deploy: schemas/myapp_memberships_private/tables/app_memberships_sprt/columns/capabilities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_private/tables/app_memberships_sprt/table
-- requires: schemas/myapp_memberships_private/tables/app_memberships_sprt/columns/capabilities/column


ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN capabilities SET DEFAULT (lpad('', 64, '0'))::bit(64);


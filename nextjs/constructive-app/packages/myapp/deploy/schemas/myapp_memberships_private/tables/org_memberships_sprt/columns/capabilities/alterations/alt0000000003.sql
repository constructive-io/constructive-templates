-- Deploy: schemas/myapp_memberships_private/tables/org_memberships_sprt/columns/capabilities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_private/tables/org_memberships_sprt/columns/capabilities/column


COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.capabilities IS E'Resolved capability bitmask for this actor-entity pair, used by RLS policies for access control';


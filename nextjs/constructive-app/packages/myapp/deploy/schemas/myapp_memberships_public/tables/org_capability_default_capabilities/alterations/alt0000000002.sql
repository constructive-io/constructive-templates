-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


COMMENT ON TABLE myapp_memberships_public.org_capability_default_capabilities IS E'Join table linking capability defaults to individual capabilities; recompute trigger rebuilds the defaults bitmask';


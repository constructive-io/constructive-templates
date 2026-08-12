-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_grants/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_grants/table


COMMENT ON TABLE myapp_memberships_public.app_capability_default_grants IS 'Audit log of capability additions and removals from the defaults bitmask';


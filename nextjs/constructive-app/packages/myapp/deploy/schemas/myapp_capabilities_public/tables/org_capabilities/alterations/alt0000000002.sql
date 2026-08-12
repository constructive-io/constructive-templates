-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


COMMENT ON TABLE myapp_capabilities_public.org_capabilities IS E'Defines available capabilities as named bits within a bitmask, used by the RBAC system for access control';


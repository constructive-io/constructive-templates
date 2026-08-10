-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


COMMENT ON TABLE myapp_capabilities_public.app_capability_defaults IS 'Stores the default capability bitmask assigned to new members upon joining';


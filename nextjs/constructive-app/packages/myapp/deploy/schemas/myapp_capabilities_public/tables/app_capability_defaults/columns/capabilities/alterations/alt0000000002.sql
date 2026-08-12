-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/capabilities/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/columns/capabilities/column


ALTER TABLE myapp_capabilities_public.app_capability_defaults 
  ALTER COLUMN capabilities SET DEFAULT (lpad('', 64, '0'))::bit(64);


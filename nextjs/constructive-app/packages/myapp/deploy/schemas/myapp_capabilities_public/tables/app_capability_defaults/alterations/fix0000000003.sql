-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/alterations/fix0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


INSERT INTO myapp_capabilities_public.app_capability_defaults (
  capabilities
)
VALUES
  (DEFAULT);


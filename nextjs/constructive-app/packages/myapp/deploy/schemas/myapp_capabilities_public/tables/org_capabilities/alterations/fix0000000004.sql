-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/alterations/fix0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


INSERT INTO myapp_capabilities_public.org_capabilities (
  bitnum,
  name,
  description
)
VALUES
  (17, 'manage_hierarchy', 'Manage organizational chart structure and reporting relationships.');


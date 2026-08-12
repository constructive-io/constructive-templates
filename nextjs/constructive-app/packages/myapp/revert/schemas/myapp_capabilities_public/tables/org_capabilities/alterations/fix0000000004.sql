-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/alterations/fix0000000004


DELETE FROM myapp_capabilities_public.org_capabilities
WHERE
  bitnum = 17 AND name = 'manage_hierarchy' AND description = 'Manage organizational chart structure and reporting relationships.';



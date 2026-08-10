-- Deploy: schemas/catalog_private/tables/resource_installations/columns/namespace_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/columns/namespace_id/column


COMMENT ON COLUMN catalog_private.resource_installations.namespace_id IS 'Namespace the installation lives in (source namespace row id)';
-- Deploy: schemas/catalog_private/tables/domains/columns/parent_hostname/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/parent_hostname/column


COMMENT ON COLUMN catalog_private.domains.parent_hostname IS 'Parent hostname a wildcard claim covers';
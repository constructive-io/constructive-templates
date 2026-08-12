-- Deploy: schemas/catalog_private/tables/domains/columns/is_wildcard/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/is_wildcard/column


COMMENT ON COLUMN catalog_private.domains.is_wildcard IS 'Whether this hostname is a wildcard claim';
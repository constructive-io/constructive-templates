-- Deploy: schemas/catalog_private/tables/domains/columns/hostname/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/hostname/column


COMMENT ON COLUMN catalog_private.domains.hostname IS 'Lowercase fully-qualified hostname; wildcards use the *.parent form';
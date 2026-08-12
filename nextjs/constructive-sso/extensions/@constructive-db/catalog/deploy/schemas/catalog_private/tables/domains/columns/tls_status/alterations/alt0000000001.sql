-- Deploy: schemas/catalog_private/tables/domains/columns/tls_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/tls_status/column


COMMENT ON COLUMN catalog_private.domains.tls_status IS 'Certificate lifecycle state propagated from the source row';
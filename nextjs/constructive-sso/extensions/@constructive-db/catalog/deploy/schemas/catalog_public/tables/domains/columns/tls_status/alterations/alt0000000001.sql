-- Deploy: schemas/catalog_public/tables/domains/columns/tls_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/columns/tls_status/column


COMMENT ON COLUMN catalog_public.domains.tls_status IS 'Certificate lifecycle state propagated from the source row';
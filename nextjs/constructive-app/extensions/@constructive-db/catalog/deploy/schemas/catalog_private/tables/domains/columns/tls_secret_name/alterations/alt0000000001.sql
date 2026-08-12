-- Deploy: schemas/catalog_private/tables/domains/columns/tls_secret_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/tls_secret_name/column


COMMENT ON COLUMN catalog_private.domains.tls_secret_name IS 'TLS secret name propagated from the source row';
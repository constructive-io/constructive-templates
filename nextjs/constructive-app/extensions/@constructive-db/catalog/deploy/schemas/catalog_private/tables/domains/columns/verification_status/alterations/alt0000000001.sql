-- Deploy: schemas/catalog_private/tables/domains/columns/verification_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/verification_status/column


COMMENT ON COLUMN catalog_private.domains.verification_status IS 'Ownership verification state propagated from the source row';
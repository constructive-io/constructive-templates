-- Deploy: schemas/catalog_private/tables/domains/columns/managed/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/columns/managed/column


COMMENT ON COLUMN catalog_private.domains.managed IS 'Whether the platform drives this hostname''s lifecycle';
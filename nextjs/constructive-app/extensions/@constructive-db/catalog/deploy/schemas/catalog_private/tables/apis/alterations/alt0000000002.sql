-- Deploy: schemas/catalog_private/tables/apis/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table


COMMENT ON TABLE catalog_private.apis IS 'Trigger-maintained typed catalog of api surfaces across all scopes; rendering config is read live from this table';
-- Deploy: schemas/catalog_public/tables/apis/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table


COMMENT ON TABLE catalog_public.apis IS 'Trigger-maintained typed catalog of api surfaces across all scopes; rendering config is read live from this table';
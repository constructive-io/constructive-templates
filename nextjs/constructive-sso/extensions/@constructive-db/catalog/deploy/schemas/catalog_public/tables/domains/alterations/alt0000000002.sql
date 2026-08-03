-- Deploy: schemas/catalog_public/tables/domains/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table


COMMENT ON TABLE catalog_public.domains IS 'Trigger-maintained typed catalog of hostnames across all scopes; UNIQUE (hostname) is the global claim';
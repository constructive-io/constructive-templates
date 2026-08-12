-- Deploy: schemas/catalog_private/tables/domains/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


COMMENT ON TABLE catalog_private.domains IS 'Trigger-maintained typed catalog of hostnames across all scopes; UNIQUE (hostname) is the global claim';
-- Deploy: schemas/catalog_private/tables/namespaces/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table


COMMENT ON TABLE catalog_private.namespaces IS 'Trigger-maintained typed catalog of namespaces across all scopes; UNIQUE (namespace_name) is the global claim';
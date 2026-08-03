-- Deploy: schemas/catalog_public/tables/namespaces/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


COMMENT ON TABLE catalog_public.namespaces IS 'Trigger-maintained typed catalog of namespaces across all scopes; UNIQUE (namespace_name) is the global claim';
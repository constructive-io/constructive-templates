-- Deploy: schemas/catalog_public/tables/resources/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


COMMENT ON TABLE catalog_public.resources IS 'Trigger-maintained typed catalog of resources across all scopes; UNIQUE (namespace_id, kind, slug)';
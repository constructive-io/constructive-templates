-- Deploy: schemas/catalog_public/tables/domains/indexes/domains_parent_hostname_is_wildcard_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/is_wildcard/column
-- requires: schemas/catalog_public/tables/domains/columns/parent_hostname/column


CREATE INDEX domains_parent_hostname_is_wildcard_idx ON catalog_public.domains (parent_hostname, is_wildcard);
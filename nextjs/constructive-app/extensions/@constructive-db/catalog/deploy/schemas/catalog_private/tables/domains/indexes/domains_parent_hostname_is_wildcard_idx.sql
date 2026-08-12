-- Deploy: schemas/catalog_private/tables/domains/indexes/domains_parent_hostname_is_wildcard_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/is_wildcard/column
-- requires: schemas/catalog_private/tables/domains/columns/parent_hostname/column


CREATE INDEX domains_parent_hostname_is_wildcard_idx ON catalog_private.domains (parent_hostname, is_wildcard);
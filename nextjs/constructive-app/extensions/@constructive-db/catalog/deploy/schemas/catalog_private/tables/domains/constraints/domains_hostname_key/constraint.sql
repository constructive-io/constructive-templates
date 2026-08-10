-- Deploy: schemas/catalog_private/tables/domains/constraints/domains_hostname_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


ALTER TABLE catalog_private.domains 
  ADD CONSTRAINT domains_hostname_key 
    UNIQUE (hostname);
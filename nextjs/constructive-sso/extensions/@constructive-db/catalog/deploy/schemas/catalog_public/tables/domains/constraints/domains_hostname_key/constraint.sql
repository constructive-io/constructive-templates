-- Deploy: schemas/catalog_public/tables/domains/constraints/domains_hostname_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table


ALTER TABLE catalog_public.domains 
  ADD CONSTRAINT domains_hostname_key 
    UNIQUE (hostname);
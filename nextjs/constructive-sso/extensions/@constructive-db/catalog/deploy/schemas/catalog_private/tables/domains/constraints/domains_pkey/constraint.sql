-- Deploy: schemas/catalog_private/tables/domains/constraints/domains_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


ALTER TABLE catalog_private.domains 
  ADD CONSTRAINT domains_pkey PRIMARY KEY (id);
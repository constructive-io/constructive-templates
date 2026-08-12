-- Deploy: schemas/catalog_private/tables/sites/constraints/sites_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table


ALTER TABLE catalog_private.sites 
  ADD CONSTRAINT sites_pkey PRIMARY KEY (id);
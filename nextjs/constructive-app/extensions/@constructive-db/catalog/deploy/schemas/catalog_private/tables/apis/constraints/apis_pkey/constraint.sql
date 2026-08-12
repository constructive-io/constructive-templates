-- Deploy: schemas/catalog_private/tables/apis/constraints/apis_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table


ALTER TABLE catalog_private.apis 
  ADD CONSTRAINT apis_pkey PRIMARY KEY (id);
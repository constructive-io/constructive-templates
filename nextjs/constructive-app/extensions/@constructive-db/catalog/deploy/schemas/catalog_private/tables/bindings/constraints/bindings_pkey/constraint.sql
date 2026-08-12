-- Deploy: schemas/catalog_private/tables/bindings/constraints/bindings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table


ALTER TABLE catalog_private.bindings 
  ADD CONSTRAINT bindings_pkey PRIMARY KEY (id);
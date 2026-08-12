-- Deploy: schemas/catalog_private/tables/functions/constraints/functions_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table


ALTER TABLE catalog_private.functions 
  ADD CONSTRAINT functions_pkey PRIMARY KEY (id);
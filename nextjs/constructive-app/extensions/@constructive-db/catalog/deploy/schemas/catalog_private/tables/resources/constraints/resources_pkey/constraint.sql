-- Deploy: schemas/catalog_private/tables/resources/constraints/resources_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table


ALTER TABLE catalog_private.resources 
  ADD CONSTRAINT resources_pkey PRIMARY KEY (id);
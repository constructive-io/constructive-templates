-- Deploy: schemas/catalog_public/tables/resources/constraints/resources_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE catalog_public.resources 
  ADD CONSTRAINT resources_pkey PRIMARY KEY (id);
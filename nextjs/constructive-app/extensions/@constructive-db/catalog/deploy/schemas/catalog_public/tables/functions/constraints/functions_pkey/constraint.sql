-- Deploy: schemas/catalog_public/tables/functions/constraints/functions_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table


ALTER TABLE catalog_public.functions 
  ADD CONSTRAINT functions_pkey PRIMARY KEY (id);
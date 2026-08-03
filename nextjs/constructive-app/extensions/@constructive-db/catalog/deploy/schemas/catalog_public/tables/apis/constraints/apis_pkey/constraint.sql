-- Deploy: schemas/catalog_public/tables/apis/constraints/apis_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table


ALTER TABLE catalog_public.apis 
  ADD CONSTRAINT apis_pkey PRIMARY KEY (id);
-- Deploy: schemas/catalog_public/tables/namespaces/constraints/namespaces_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


ALTER TABLE catalog_public.namespaces 
  ADD CONSTRAINT namespaces_pkey PRIMARY KEY (id);
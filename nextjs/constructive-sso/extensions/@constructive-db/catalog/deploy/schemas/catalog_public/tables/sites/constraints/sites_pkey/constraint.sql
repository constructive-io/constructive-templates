-- Deploy: schemas/catalog_public/tables/sites/constraints/sites_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table


ALTER TABLE catalog_public.sites 
  ADD CONSTRAINT sites_pkey PRIMARY KEY (id);
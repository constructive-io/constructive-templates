-- Deploy: schemas/catalog_public/tables/domains/constraints/domains_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table


ALTER TABLE catalog_public.domains 
  ADD CONSTRAINT domains_pkey PRIMARY KEY (id);
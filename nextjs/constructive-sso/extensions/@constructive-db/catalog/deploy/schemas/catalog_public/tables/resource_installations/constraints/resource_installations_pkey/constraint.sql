-- Deploy: schemas/catalog_public/tables/resource_installations/constraints/resource_installations_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table


ALTER TABLE catalog_public.resource_installations 
  ADD CONSTRAINT resource_installations_pkey PRIMARY KEY (id);
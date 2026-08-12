-- Deploy: schemas/catalog_private/tables/resource_installations/constraints/resource_installations_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table


ALTER TABLE catalog_private.resource_installations 
  ADD CONSTRAINT resource_installations_pkey PRIMARY KEY (id);
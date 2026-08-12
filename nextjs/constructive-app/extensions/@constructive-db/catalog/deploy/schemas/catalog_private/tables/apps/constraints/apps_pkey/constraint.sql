-- Deploy: schemas/catalog_private/tables/apps/constraints/apps_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table


ALTER TABLE catalog_private.apps 
  ADD CONSTRAINT apps_pkey PRIMARY KEY (id);
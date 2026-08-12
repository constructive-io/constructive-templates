-- Deploy: schemas/catalog_public/tables/apps/constraints/apps_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table


ALTER TABLE catalog_public.apps 
  ADD CONSTRAINT apps_pkey PRIMARY KEY (id);
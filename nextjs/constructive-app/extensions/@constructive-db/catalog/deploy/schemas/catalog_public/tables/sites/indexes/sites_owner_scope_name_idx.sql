-- Deploy: schemas/catalog_public/tables/sites/indexes/sites_owner_scope_name_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/name/column
-- requires: schemas/catalog_public/tables/sites/columns/owner_key/column
-- requires: schemas/catalog_public/tables/sites/columns/owner_scope/column


CREATE UNIQUE INDEX sites_owner_scope_name_idx ON catalog_public.sites (owner_scope, name) WHERE sites.owner_key IS NULL;
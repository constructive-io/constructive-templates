-- Deploy: schemas/catalog_public/tables/sites/indexes/sites_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/created_at/column


CREATE INDEX sites_created_at_idx ON catalog_public.sites (created_at);
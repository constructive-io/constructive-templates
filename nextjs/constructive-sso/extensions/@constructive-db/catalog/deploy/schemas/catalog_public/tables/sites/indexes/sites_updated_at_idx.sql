-- Deploy: schemas/catalog_public/tables/sites/indexes/sites_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/updated_at/column


CREATE INDEX sites_updated_at_idx ON catalog_public.sites (updated_at);
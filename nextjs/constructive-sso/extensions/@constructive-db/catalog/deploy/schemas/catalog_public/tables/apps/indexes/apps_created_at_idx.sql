-- Deploy: schemas/catalog_public/tables/apps/indexes/apps_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table
-- requires: schemas/catalog_public/tables/apps/columns/created_at/column


CREATE INDEX apps_created_at_idx ON catalog_public.apps (created_at);
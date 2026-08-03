-- Deploy: schemas/catalog_public/tables/functions/indexes/functions_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/updated_at/column


CREATE INDEX functions_updated_at_idx ON catalog_public.functions (updated_at);
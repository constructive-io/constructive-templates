-- Deploy: schemas/catalog_private/tables/resource_installations/indexes/resource_installations_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/updated_at/column


CREATE INDEX resource_installations_updated_at_idx ON catalog_private.resource_installations (updated_at);
-- Deploy: schemas/catalog_public/tables/apis/indexes/apis_owner_scope_owner_key_name_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/name/column
-- requires: schemas/catalog_public/tables/apis/columns/owner_key/column
-- requires: schemas/catalog_public/tables/apis/columns/owner_scope/column


CREATE UNIQUE INDEX apis_owner_scope_owner_key_name_idx ON catalog_public.apis (owner_scope, owner_key, name) WHERE apis.owner_key IS NOT NULL;
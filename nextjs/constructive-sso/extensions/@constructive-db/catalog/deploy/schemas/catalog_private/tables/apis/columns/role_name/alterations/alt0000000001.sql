-- Deploy: schemas/catalog_private/tables/apis/columns/role_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/columns/role_name/column


COMMENT ON COLUMN catalog_private.apis.role_name IS 'Authenticated role the api executes as';
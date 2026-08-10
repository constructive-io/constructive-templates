-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/realm/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/realm/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.realm IS E'Optional discriminator scoping this value under its name. NULL = the default/unqualified value; getters fall back from an exact realm match to the NULL-realm row.';


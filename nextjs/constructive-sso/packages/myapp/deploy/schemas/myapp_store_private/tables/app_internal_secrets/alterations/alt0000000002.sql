-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


COMMENT ON TABLE myapp_store_private.app_internal_secrets IS E'app-level PGP-encrypted key-value secrets store';


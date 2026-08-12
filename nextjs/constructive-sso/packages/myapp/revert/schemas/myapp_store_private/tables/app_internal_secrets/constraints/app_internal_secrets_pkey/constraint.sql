-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/constraints/app_internal_secrets_pkey/constraint


ALTER TABLE myapp_store_private.app_internal_secrets 
  DROP CONSTRAINT app_internal_secrets_pkey;



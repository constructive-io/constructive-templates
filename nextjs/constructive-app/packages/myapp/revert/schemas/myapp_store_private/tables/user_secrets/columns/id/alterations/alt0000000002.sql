-- Revert: schemas/myapp_store_private/tables/user_secrets/columns/id/alterations/alt0000000002


ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN id DROP DEFAULT;



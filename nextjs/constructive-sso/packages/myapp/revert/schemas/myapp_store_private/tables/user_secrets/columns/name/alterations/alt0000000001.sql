-- Revert: schemas/myapp_store_private/tables/user_secrets/columns/name/alterations/alt0000000001


ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN name DROP NOT NULL;



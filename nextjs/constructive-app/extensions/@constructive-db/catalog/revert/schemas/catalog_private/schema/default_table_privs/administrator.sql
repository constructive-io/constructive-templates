-- Revert: schemas/catalog_private/schema/default_table_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  REVOKE ALL ON TABLES FROM administrator RESTRICT;
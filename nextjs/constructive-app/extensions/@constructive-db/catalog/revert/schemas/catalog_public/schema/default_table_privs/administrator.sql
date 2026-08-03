-- Revert: schemas/catalog_public/schema/default_table_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  REVOKE ALL ON TABLES FROM administrator RESTRICT;
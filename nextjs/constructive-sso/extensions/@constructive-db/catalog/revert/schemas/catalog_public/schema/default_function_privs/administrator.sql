-- Revert: schemas/catalog_public/schema/default_function_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  REVOKE ALL ON FUNCTIONS FROM administrator RESTRICT;
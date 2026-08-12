-- Revert: schemas/catalog_private/schema/default_function_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  REVOKE ALL ON FUNCTIONS FROM administrator RESTRICT;
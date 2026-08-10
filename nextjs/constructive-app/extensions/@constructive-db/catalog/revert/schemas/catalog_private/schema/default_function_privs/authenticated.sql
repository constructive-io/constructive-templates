-- Revert: schemas/catalog_private/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  REVOKE ALL ON FUNCTIONS FROM authenticated RESTRICT;
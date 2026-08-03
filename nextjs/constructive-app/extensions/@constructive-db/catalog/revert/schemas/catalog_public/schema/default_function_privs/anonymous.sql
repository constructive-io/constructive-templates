-- Revert: schemas/catalog_public/schema/default_function_privs/anonymous


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  REVOKE ALL ON FUNCTIONS FROM anonymous RESTRICT;
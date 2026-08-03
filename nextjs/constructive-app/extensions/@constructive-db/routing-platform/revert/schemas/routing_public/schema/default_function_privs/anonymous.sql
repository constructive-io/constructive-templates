-- Revert: schemas/routing_public/schema/default_function_privs/anonymous


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_public
  REVOKE ALL ON FUNCTIONS FROM anonymous RESTRICT;
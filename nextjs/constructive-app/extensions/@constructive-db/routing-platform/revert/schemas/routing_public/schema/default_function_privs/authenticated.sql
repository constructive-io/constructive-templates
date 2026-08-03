-- Revert: schemas/routing_public/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_public
  REVOKE ALL ON FUNCTIONS FROM authenticated RESTRICT;
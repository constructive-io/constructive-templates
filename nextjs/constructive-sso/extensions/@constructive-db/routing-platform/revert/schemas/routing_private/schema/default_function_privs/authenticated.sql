-- Revert: schemas/routing_private/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_private
  REVOKE ALL ON FUNCTIONS FROM authenticated RESTRICT;
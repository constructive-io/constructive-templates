-- Revert: schemas/platform_routing_public/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_public
  REVOKE ALL ON FUNCTIONS FROM authenticated RESTRICT;
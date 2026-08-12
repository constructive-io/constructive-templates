-- Revert: schemas/platform_routing_private/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_private
  REVOKE ALL ON FUNCTIONS FROM authenticated RESTRICT;
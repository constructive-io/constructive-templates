-- Revert: schemas/platform_routing_private/schema/default_function_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_private
  REVOKE ALL ON FUNCTIONS FROM administrator RESTRICT;
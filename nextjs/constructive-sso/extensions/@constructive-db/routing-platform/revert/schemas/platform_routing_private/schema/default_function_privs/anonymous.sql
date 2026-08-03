-- Revert: schemas/platform_routing_private/schema/default_function_privs/anonymous


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_private
  REVOKE ALL ON FUNCTIONS FROM anonymous RESTRICT;
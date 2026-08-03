-- Revert: schemas/platform_routing_private/schema/default_seq_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_private
  REVOKE USAGE ON SEQUENCES FROM authenticated RESTRICT;
-- Revert: schemas/platform_routing_public/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_public
  REVOKE USAGE ON SEQUENCES FROM administrator RESTRICT;
-- Revert: schemas/routing_private/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_private
  REVOKE USAGE ON SEQUENCES FROM administrator RESTRICT;
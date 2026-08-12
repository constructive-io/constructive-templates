-- Revert: schemas/routing_public/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_public
  REVOKE USAGE ON SEQUENCES FROM administrator RESTRICT;
-- Revert: schemas/routing_private/schema/default_table_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_private
  REVOKE ALL ON TABLES FROM administrator RESTRICT;
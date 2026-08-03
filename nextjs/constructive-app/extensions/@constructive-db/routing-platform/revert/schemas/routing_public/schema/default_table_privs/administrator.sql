-- Revert: schemas/routing_public/schema/default_table_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_public
  REVOKE ALL ON TABLES FROM administrator RESTRICT;
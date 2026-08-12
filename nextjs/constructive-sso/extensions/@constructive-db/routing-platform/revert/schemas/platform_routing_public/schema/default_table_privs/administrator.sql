-- Revert: schemas/platform_routing_public/schema/default_table_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_public
  REVOKE ALL ON TABLES FROM administrator RESTRICT;
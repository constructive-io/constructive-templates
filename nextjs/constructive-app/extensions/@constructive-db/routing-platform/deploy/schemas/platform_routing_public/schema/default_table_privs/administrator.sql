-- Deploy: schemas/platform_routing_public/schema/default_table_privs/administrator
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_public
  GRANT ALL ON TABLES TO administrator;
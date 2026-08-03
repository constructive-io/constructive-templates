-- Deploy: schemas/platform_routing_private/schema/default_seq_privs/administrator
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_private/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA platform_routing_private
  GRANT USAGE ON SEQUENCES TO administrator;
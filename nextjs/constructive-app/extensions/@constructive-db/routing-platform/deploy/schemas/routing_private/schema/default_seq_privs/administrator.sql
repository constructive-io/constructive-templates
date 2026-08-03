-- Deploy: schemas/routing_private/schema/default_seq_privs/administrator
-- made with <3 @ constructive.io

-- requires: schemas/routing_private/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_private
  GRANT USAGE ON SEQUENCES TO administrator;
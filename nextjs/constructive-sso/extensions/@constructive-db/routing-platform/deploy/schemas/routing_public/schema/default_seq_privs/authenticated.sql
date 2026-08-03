-- Deploy: schemas/routing_public/schema/default_seq_privs/authenticated
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_public
  GRANT USAGE ON SEQUENCES TO authenticated;
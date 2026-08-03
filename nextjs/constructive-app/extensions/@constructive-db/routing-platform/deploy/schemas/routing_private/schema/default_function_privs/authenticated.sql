-- Deploy: schemas/routing_private/schema/default_function_privs/authenticated
-- made with <3 @ constructive.io

-- requires: schemas/routing_private/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_private
  GRANT ALL ON FUNCTIONS TO authenticated;
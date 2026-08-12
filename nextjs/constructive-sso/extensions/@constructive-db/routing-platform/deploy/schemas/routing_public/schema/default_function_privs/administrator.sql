-- Deploy: schemas/routing_public/schema/default_function_privs/administrator
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA routing_public
  GRANT ALL ON FUNCTIONS TO administrator;
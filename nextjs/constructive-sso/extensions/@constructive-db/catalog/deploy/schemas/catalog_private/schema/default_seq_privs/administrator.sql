-- Deploy: schemas/catalog_private/schema/default_seq_privs/administrator
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT USAGE ON SEQUENCES TO administrator;
-- Revert: schemas/catalog_private/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  REVOKE USAGE ON SEQUENCES FROM administrator RESTRICT;
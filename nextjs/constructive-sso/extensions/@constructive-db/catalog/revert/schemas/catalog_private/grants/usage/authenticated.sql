-- Revert: schemas/catalog_private/grants/usage/authenticated


REVOKE USAGE ON SCHEMA catalog_private FROM authenticated RESTRICT;
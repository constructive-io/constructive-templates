-- Revert: schemas/catalog_private/grants/usage/anonymous


REVOKE USAGE ON SCHEMA catalog_private FROM anonymous RESTRICT;
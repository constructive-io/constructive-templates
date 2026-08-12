-- Revert: schemas/catalog_private/tables/domains/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.domains FROM authenticated RESTRICT;
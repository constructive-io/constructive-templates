-- Revert: schemas/catalog_private/tables/domains/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.domains FROM authenticated RESTRICT;
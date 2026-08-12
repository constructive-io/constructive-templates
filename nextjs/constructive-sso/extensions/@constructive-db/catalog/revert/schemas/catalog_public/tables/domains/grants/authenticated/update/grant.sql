-- Revert: schemas/catalog_public/tables/domains/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.domains FROM authenticated RESTRICT;
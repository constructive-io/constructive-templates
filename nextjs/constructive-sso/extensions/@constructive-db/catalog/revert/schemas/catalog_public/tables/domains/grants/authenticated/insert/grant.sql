-- Revert: schemas/catalog_public/tables/domains/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.domains FROM authenticated RESTRICT;
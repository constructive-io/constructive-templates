-- Revert: schemas/catalog_public/tables/resources/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.resources FROM authenticated RESTRICT;
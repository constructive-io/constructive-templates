-- Revert: schemas/catalog_public/tables/functions/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.functions FROM authenticated RESTRICT;
-- Revert: schemas/catalog_public/tables/sites/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.sites FROM authenticated RESTRICT;
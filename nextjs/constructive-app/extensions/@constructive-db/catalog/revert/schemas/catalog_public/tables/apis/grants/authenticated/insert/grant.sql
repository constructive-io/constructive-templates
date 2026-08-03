-- Revert: schemas/catalog_public/tables/apis/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.apis FROM authenticated RESTRICT;
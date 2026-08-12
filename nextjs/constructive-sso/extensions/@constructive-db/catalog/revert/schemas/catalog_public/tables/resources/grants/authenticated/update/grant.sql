-- Revert: schemas/catalog_public/tables/resources/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.resources FROM authenticated RESTRICT;
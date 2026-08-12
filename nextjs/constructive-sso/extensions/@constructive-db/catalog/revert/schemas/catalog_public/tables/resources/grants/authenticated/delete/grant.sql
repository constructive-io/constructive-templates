-- Revert: schemas/catalog_public/tables/resources/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.resources FROM authenticated RESTRICT;
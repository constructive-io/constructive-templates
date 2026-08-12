-- Revert: schemas/catalog_public/tables/functions/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.functions FROM authenticated RESTRICT;
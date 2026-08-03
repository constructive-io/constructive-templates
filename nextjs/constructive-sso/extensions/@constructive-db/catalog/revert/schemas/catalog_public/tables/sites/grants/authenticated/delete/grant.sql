-- Revert: schemas/catalog_public/tables/sites/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.sites FROM authenticated RESTRICT;
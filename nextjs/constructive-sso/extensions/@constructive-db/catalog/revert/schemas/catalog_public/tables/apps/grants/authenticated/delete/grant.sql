-- Revert: schemas/catalog_public/tables/apps/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.apps FROM authenticated RESTRICT;
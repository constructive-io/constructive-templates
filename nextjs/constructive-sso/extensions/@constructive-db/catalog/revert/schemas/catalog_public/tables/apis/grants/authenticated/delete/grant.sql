-- Revert: schemas/catalog_public/tables/apis/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.apis FROM authenticated RESTRICT;
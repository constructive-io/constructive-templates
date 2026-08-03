-- Revert: schemas/catalog_public/tables/domains/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.domains FROM authenticated RESTRICT;
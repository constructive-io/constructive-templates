-- Revert: schemas/routing_public/tables/site_modules/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_modules FROM authenticated RESTRICT;
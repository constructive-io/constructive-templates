-- Revert: schemas/routing_public/tables/site_modules/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_modules FROM authenticated RESTRICT;
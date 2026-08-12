-- Revert: schemas/routing_public/tables/platform_site_modules/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_site_modules FROM authenticated RESTRICT;
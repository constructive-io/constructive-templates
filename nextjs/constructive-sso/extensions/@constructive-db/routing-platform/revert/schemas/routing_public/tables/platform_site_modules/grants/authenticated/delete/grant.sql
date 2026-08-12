-- Revert: schemas/routing_public/tables/platform_site_modules/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_modules FROM authenticated RESTRICT;
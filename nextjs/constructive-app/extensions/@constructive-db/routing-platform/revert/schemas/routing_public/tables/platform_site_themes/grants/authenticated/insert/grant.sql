-- Revert: schemas/routing_public/tables/platform_site_themes/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_site_themes FROM authenticated RESTRICT;
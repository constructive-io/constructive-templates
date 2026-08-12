-- Revert: schemas/routing_public/tables/platform_site_app_links/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_site_app_links FROM authenticated RESTRICT;
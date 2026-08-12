-- Revert: schemas/routing_public/tables/platform_site_app_links/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_app_links FROM authenticated RESTRICT;
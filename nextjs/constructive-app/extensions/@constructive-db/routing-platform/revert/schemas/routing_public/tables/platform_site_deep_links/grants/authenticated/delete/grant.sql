-- Revert: schemas/routing_public/tables/platform_site_deep_links/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_deep_links FROM authenticated RESTRICT;
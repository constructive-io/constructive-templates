-- Revert: schemas/routing_public/tables/platform_site_themes/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_themes FROM authenticated RESTRICT;
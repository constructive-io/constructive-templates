-- Revert: schemas/routing_public/tables/platform_site_web_configs/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_web_configs FROM authenticated RESTRICT;
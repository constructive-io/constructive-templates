-- Revert: schemas/routing_public/tables/site_app_links/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_app_links FROM authenticated RESTRICT;
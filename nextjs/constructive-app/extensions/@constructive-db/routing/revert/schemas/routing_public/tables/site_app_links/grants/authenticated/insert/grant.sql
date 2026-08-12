-- Revert: schemas/routing_public/tables/site_app_links/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_app_links FROM authenticated RESTRICT;
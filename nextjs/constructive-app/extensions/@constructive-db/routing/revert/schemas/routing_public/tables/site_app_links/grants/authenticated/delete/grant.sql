-- Revert: schemas/routing_public/tables/site_app_links/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_app_links FROM authenticated RESTRICT;
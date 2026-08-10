-- Revert: schemas/routing_public/tables/site_app_links/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_app_links FROM authenticated RESTRICT;
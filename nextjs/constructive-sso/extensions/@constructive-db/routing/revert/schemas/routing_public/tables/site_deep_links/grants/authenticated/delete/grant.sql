-- Revert: schemas/routing_public/tables/site_deep_links/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_deep_links FROM authenticated RESTRICT;
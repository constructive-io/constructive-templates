-- Revert: schemas/routing_public/tables/site_deep_links/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_deep_links FROM authenticated RESTRICT;
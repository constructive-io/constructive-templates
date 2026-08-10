-- Revert: schemas/routing_public/tables/site_deep_links/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_deep_links FROM authenticated RESTRICT;
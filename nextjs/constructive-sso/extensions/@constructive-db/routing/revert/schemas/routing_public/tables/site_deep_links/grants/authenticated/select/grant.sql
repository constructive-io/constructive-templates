-- Revert: schemas/routing_public/tables/site_deep_links/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_deep_links FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/site_themes/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_themes FROM authenticated RESTRICT;
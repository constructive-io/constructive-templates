-- Revert: schemas/routing_public/tables/site_themes/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_themes FROM authenticated RESTRICT;
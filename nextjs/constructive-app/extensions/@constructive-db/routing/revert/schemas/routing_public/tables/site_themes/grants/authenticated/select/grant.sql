-- Revert: schemas/routing_public/tables/site_themes/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_themes FROM authenticated RESTRICT;
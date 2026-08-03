-- Revert: schemas/routing_public/tables/site_themes/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_themes FROM authenticated RESTRICT;
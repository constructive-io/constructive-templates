-- Revert: schemas/routing_public/tables/site_web_configs/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_web_configs FROM authenticated RESTRICT;
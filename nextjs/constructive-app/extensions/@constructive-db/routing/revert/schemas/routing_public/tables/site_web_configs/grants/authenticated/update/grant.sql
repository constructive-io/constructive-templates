-- Revert: schemas/routing_public/tables/site_web_configs/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_web_configs FROM authenticated RESTRICT;
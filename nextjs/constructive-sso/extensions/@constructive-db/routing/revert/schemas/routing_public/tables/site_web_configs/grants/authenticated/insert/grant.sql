-- Revert: schemas/routing_public/tables/site_web_configs/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_web_configs FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/site_web_configs/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_web_configs FROM authenticated RESTRICT;
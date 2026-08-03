-- Revert: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_cors_settings FROM authenticated RESTRICT;
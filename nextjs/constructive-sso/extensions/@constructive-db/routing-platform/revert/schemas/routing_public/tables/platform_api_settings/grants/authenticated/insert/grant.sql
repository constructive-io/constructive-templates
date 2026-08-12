-- Revert: schemas/routing_public/tables/platform_api_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_api_settings FROM authenticated RESTRICT;
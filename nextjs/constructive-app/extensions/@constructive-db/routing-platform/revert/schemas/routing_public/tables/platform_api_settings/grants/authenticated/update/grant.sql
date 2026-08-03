-- Revert: schemas/routing_public/tables/platform_api_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_api_settings FROM authenticated RESTRICT;
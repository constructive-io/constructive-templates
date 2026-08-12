-- Revert: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_cors_settings FROM authenticated RESTRICT;
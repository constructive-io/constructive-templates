-- Revert: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_cors_settings FROM authenticated RESTRICT;
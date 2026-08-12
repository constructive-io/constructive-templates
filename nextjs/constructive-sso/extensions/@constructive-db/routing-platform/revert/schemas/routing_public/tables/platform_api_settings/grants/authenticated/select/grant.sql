-- Revert: schemas/routing_public/tables/platform_api_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_api_settings FROM authenticated RESTRICT;
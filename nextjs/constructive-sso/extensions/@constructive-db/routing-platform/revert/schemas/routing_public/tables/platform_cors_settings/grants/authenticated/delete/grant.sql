-- Revert: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_cors_settings FROM authenticated RESTRICT;
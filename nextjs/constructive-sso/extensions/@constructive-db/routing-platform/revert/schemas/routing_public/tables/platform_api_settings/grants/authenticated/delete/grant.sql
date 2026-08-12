-- Revert: schemas/routing_public/tables/platform_api_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_api_settings FROM authenticated RESTRICT;
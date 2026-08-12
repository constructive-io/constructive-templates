-- Revert: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_api_schemas FROM authenticated RESTRICT;
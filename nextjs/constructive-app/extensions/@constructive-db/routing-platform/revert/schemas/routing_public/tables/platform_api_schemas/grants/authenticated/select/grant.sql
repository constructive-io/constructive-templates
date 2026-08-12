-- Revert: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_api_schemas FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_api_schemas FROM authenticated RESTRICT;
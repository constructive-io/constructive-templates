-- Revert: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_api_schemas FROM authenticated RESTRICT;
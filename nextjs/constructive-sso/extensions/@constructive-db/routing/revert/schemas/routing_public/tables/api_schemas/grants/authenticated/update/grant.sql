-- Revert: schemas/routing_public/tables/api_schemas/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.api_schemas FROM authenticated RESTRICT;
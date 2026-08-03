-- Revert: schemas/routing_public/tables/api_schemas/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.api_schemas FROM authenticated RESTRICT;
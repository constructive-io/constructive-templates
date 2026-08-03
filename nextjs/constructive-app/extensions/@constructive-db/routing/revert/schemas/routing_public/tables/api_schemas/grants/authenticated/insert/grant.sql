-- Revert: schemas/routing_public/tables/api_schemas/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.api_schemas FROM authenticated RESTRICT;
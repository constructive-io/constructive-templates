-- Revert: schemas/routing_public/tables/api_schemas/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.api_schemas FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/api_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.api_settings FROM authenticated RESTRICT;
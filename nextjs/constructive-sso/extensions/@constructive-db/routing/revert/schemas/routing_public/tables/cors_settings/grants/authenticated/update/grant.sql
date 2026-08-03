-- Revert: schemas/routing_public/tables/cors_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.cors_settings FROM authenticated RESTRICT;
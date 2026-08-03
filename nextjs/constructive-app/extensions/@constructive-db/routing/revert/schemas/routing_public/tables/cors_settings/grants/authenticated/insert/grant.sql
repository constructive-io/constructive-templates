-- Revert: schemas/routing_public/tables/cors_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.cors_settings FROM authenticated RESTRICT;
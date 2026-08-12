-- Revert: schemas/routing_public/tables/cors_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.cors_settings FROM authenticated RESTRICT;
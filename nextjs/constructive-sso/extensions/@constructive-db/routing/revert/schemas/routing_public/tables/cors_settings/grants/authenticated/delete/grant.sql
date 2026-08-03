-- Revert: schemas/routing_public/tables/cors_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.cors_settings FROM authenticated RESTRICT;
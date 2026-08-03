-- Revert: schemas/routing_public/tables/database_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.database_settings FROM authenticated RESTRICT;
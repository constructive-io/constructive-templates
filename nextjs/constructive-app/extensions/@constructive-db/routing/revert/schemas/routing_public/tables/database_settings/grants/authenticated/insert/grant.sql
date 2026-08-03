-- Revert: schemas/routing_public/tables/database_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.database_settings FROM authenticated RESTRICT;
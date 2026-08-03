-- Revert: schemas/routing_public/tables/database_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.database_settings FROM authenticated RESTRICT;
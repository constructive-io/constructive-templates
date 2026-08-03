-- Revert: schemas/routing_public/tables/database_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.database_settings FROM authenticated RESTRICT;
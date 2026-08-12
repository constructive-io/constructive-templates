-- Revert: schemas/routing_public/tables/rls_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.rls_settings FROM authenticated RESTRICT;
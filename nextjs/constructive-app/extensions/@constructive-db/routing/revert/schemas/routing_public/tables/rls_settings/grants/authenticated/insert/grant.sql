-- Revert: schemas/routing_public/tables/rls_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.rls_settings FROM authenticated RESTRICT;
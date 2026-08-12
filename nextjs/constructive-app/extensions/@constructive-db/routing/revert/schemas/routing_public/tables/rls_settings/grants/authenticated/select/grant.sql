-- Revert: schemas/routing_public/tables/rls_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.rls_settings FROM authenticated RESTRICT;
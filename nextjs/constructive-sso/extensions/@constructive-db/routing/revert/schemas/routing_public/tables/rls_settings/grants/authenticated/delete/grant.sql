-- Revert: schemas/routing_public/tables/rls_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.rls_settings FROM authenticated RESTRICT;
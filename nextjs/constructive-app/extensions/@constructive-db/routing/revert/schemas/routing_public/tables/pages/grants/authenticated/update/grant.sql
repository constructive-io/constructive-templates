-- Revert: schemas/routing_public/tables/pages/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.pages FROM authenticated RESTRICT;
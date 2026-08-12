-- Revert: schemas/routing_public/tables/pages/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.pages FROM authenticated RESTRICT;
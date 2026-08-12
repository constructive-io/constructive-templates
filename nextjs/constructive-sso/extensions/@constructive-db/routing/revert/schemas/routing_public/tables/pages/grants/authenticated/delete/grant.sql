-- Revert: schemas/routing_public/tables/pages/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.pages FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/pages/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.pages FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/apis/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.apis FROM authenticated RESTRICT;
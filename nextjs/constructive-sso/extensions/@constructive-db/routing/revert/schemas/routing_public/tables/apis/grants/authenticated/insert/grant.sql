-- Revert: schemas/routing_public/tables/apis/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.apis FROM authenticated RESTRICT;
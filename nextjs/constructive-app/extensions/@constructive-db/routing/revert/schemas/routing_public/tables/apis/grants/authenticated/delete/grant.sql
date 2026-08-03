-- Revert: schemas/routing_public/tables/apis/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.apis FROM authenticated RESTRICT;
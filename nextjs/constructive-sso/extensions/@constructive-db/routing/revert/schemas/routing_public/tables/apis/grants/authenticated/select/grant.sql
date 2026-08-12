-- Revert: schemas/routing_public/tables/apis/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.apis FROM authenticated RESTRICT;
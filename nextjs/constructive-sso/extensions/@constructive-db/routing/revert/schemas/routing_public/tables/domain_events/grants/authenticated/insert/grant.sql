-- Revert: schemas/routing_public/tables/domain_events/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.domain_events FROM authenticated RESTRICT;
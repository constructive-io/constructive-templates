-- Revert: schemas/routing_public/tables/domain_events/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.domain_events FROM authenticated RESTRICT;
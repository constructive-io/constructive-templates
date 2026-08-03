-- Revert: schemas/routing_public/tables/domain_events/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.domain_events FROM authenticated RESTRICT;
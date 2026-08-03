-- Revert: schemas/routing_public/tables/domain_events/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.domain_events FROM authenticated RESTRICT;
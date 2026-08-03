-- Revert: schemas/routing_public/tables/platform_domain_events/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_domain_events FROM authenticated RESTRICT;
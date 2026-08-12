-- Revert: schemas/routing_public/tables/platform_domain_events/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_domain_events FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/platform_domain_events/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_domain_events FROM authenticated RESTRICT;
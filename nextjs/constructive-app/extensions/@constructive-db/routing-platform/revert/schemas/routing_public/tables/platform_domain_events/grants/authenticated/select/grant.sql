-- Revert: schemas/routing_public/tables/platform_domain_events/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_domain_events FROM authenticated RESTRICT;
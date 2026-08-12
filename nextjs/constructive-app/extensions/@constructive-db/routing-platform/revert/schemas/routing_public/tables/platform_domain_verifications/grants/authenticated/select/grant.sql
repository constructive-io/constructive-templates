-- Revert: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_domain_verifications FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_domain_verifications FROM authenticated RESTRICT;
-- Revert: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_domain_verifications FROM authenticated RESTRICT;
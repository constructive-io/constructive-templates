-- Revert: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_domain_verifications FROM authenticated RESTRICT;
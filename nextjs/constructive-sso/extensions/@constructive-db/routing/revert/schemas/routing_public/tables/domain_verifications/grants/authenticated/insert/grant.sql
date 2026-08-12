-- Revert: schemas/routing_public/tables/domain_verifications/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.domain_verifications FROM authenticated RESTRICT;
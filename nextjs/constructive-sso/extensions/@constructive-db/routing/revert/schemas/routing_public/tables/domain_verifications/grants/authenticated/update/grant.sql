-- Revert: schemas/routing_public/tables/domain_verifications/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.domain_verifications FROM authenticated RESTRICT;
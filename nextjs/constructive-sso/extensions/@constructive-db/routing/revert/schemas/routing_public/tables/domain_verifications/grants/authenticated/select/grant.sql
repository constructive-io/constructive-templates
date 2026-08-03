-- Revert: schemas/routing_public/tables/domain_verifications/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.domain_verifications FROM authenticated RESTRICT;